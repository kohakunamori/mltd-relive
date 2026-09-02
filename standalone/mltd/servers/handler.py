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


# Diagnostic A/B override: keep the complete v0.1.9 server/runtime, but restore
# only TheaterService.GetTheater to the conservative v0.1.6 response.  This
# intentionally bypasses dynamic theater contacts/resource_id loading so a real
# game client can determine whether login -404 is caused by Theater assets.
@dispatcher.add_method(name='TheaterService.GetTheater')
def _diagnostic_static_get_theater(params):
    return {
        'theater_opening': {
            'mst_theater_opening_id': 0,
            'opening_type': 0,
            'resource_id': '',
            'jump_type': '',
            'cue_sheet': '',
            'cue_name': '',
            'mv_status': {
                'mst_song_id': 0,
                'mv_unit_idol_list': None
            }
        },
        'theater_opening_list': None,
        'theater': {
            'room_list': [],
            'idol_booking_list': [],
            'theater_display_room': {
                'mst_room_id': 0,
                'balloon': {
                    'theater_contact_category_type': 0,
                    'room_idol_list': None,
                    'resource_id': '',
                    'mst_theater_contact_schedule_id': 0,
                    'mst_theater_contact_id': 0,
                    'mst_theater_main_story_id': 0,
                    'mst_theater_guest_main_story_id': 0,
                    'guest_main_story_has_intro': False,
                    'mst_guest_main_story_id': 0,
                    'mst_theater_blog_id': 0,
                    'mst_theater_costume_blog_id': 0,
                    'mst_costume_id': 0,
                    'mst_theater_event_story_id': 0,
                    'mst_event_story_id': 0,
                    'mst_event_id': 0
                }
            },
            'prior_lot_rate_table_list': []
        }
    }


_SLOW_REQUEST_MS = 25
_BATCH_METHOD_PREVIEW = 12
_ALLOWED_API_HOSTS = frozenset({
    'theaterdays-zh.appspot.com',
    'theaterdays-ko.appspot.com',
    'theaterdays.appspot.com',
    '127.0.0.1',
})


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


def _normalize_host(host):
    host = (host or '').strip().lower()
    if host.startswith('['):
        end = host.find(']')
        if end != -1:
            return host[1:end]
    if ':' in host:
        host = host.rsplit(':', 1)[0]
    return host


def _is_allowed_api_host(host):
    return _normalize_host(host) in _ALLOWED_API_HOSTS


def application(environ, start_response):
    host = environ.get('HTTP_HOST', '')

    if _is_allowed_api_host(host):
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