import json
import logging
import time
from datetime import datetime
from decimal import Decimal
from uuid import UUID

from jsonrpc import JSONRPCResponseManager, dispatcher

from mltd.servers.encryption import decrypt_request, encrypt_response
from mltd.servers.logging import logger
from mltd.servers.utilities import format_datetime
from mltd.services import *

_SLOW_REQUEST_MS = 25
_BATCH_METHOD_PREVIEW = 12


class CustomJSONEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, UUID):
            return str(o)
        elif isinstance(o, Decimal):
            return float(o.normalize())
        elif isinstance(o, datetime):
            return format_datetime(o)
        return json.JSONEncoder.default(self, o)


def _method_name(request):
    try:
        payload = json.loads(request)
        if isinstance(payload, dict):
            return payload.get('method') or '?'
        if isinstance(payload, list):
            methods = [
                item.get('method') or '?'
                for item in payload
                if isinstance(item, dict)
            ]
            preview = methods[:_BATCH_METHOD_PREVIEW]
            label = ','.join(preview)
            if len(methods) > len(preview):
                label += f',+{len(methods) - len(preview)} more'
            return f'batch[{len(payload)}]({label})'
    except (TypeError, ValueError, UnicodeDecodeError):
        pass
    return '?'


def application(environ, start_response):
    host = environ['HTTP_HOST']

    if ('theaterdays-zh.appspot.com' in host
            or 'theaterdays-ko.appspot.com' in host
            or '127.0.0.1' in host):
        debug = logger.isEnabledFor(logging.DEBUG)
        full_start_time = time.perf_counter_ns()

        status = '200 OK'
        headers = [
            ('Content-Type', 'application/json'),
            ('X-Encryption', 'on'),
            ('X-Encryption-Compress', 'gzip'),
            ('X-Encryption-Mode', '3'),
        ]

        request_len = int(environ['CONTENT_LENGTH'])
        encrypted_request = environ['wsgi.input'].read(request_len)
        decrypt_start_time = time.perf_counter_ns()
        request = decrypt_request(encrypted_request)
        decrypt_end_time = time.perf_counter_ns()
        method = _method_name(request)

        if debug:
            logger.debug(
                f'Request received for {method} '
                f'at {environ["PATH_INFO"]}'
            )
            logger.debug(request)

        context = {
            'user_id': environ.get('HTTP_X_APPLICATION_USER_ID'),
        }
        svc_start_time = time.perf_counter_ns()
        response = JSONRPCResponseManager.handle(request, dispatcher, context)
        svc_end_time = time.perf_counter_ns()

        if debug:
            logger.debug(
                json.dumps(response.data, cls=CustomJSONEncoder, indent=2)
            )

        json_start_time = time.perf_counter_ns()
        response_json = json.dumps(
            response.data,
            cls=CustomJSONEncoder,
            separators=(',', ':'),
            check_circular=False,
        )
        json_end_time = time.perf_counter_ns()

        encrypt_start_time = time.perf_counter_ns()
        response = encrypt_response(response_json)
        encrypt_end_time = time.perf_counter_ns()

        full_end_time = encrypt_end_time
        decrypt_ms = (decrypt_end_time - decrypt_start_time) / 1_000_000
        svc_ms = (svc_end_time - svc_start_time) / 1_000_000
        json_ms = (json_end_time - json_start_time) / 1_000_000
        encrypt_ms = (encrypt_end_time - encrypt_start_time) / 1_000_000
        full_ms = (full_end_time - full_start_time) / 1_000_000

        if debug or full_ms >= _SLOW_REQUEST_MS:
            message = (
                f'API timing {method}: full={full_ms:.2f} ms '
                f'decrypt={decrypt_ms:.2f} ms service={svc_ms:.2f} ms '
                f'json={json_ms:.2f} ms encrypt={encrypt_ms:.2f} ms '
                f'json_bytes={len(response_json)} wire_bytes={len(response)}'
            )
            if debug:
                logger.debug(message)
            else:
                logger.warning('Slow ' + message)

        start_response(status, headers)
        return [response]

    status = '503 Service Unavailable'
    headers = [('Content-Type', 'text/html')]
    start_response(status, headers)
    return [b'503 Service Unavailable']
