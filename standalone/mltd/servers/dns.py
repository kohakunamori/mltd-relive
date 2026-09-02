from time import sleep

import netifaces
from dnslib.intercept import InterceptResolver
from dnslib.server import DNSLogger, DNSServer

from mltd.servers.logging import logger

dns_port = 53
_API_HOSTS = (
    'theaterdays-zh.appspot.com',
    'theaterdays-ko.appspot.com',
    'theaterdays.appspot.com',
)


def get_lan_ips():
    try:
        iface = netifaces.gateways()['default'][netifaces.AF_INET][1]
        ipv4 = netifaces.ifaddresses(iface)[netifaces.AF_INET][0]['addr']
    except Exception:
        ipv4 = None
    try:
        iface = netifaces.gateways()['default'][netifaces.AF_INET6][1]
        ipv6 = netifaces.ifaddresses(iface)[netifaces.AF_INET6][0]['addr']
    except Exception:
        ipv6 = None
    return ipv4, ipv6


def build_zone_record(lan_ipv4, lan_ipv6):
    """Build DNS overrides used by corrected clients.

    Only API hostnames are intercepted. Desktop hybrid/local asset traffic
    reuses the already-intercepted theaterdays-{language}.appspot.com host on
    the dedicated cleartext HTTP asset port (7651), so the public Rainbow CDN
    hostname must keep resolving normally.
    """
    records = []
    if lan_ipv4:
        records.extend(
            f'{host}. 60 IN A {lan_ipv4}' for host in _API_HOSTS
        )
    if lan_ipv6:
        records.extend(
            f'{host}. 60 IN AAAA {lan_ipv6}' for host in _API_HOSTS
        )
    return '\n'.join(records) + ('\n' if records else '')


def start(port=dns_port, conn=None):
    lan_ipv4, lan_ipv6 = get_lan_ips()
    zone_record = build_zone_record(lan_ipv4, lan_ipv6)

    resolver = InterceptResolver(address='8.8.8.8',
                                 port=53,
                                 ttl='60s',
                                 intercept=[zone_record],
                                 skip=[],
                                 nxdomain=[],
                                 forward=[],
                                 all_qtypes=False,
                                 timeout=5)
    dns_logger = DNSLogger(logf=logger.debug)
    udp_server = DNSServer(resolver, port=port, logger=dns_logger)
    logger.info(f'DNS is running on port {port}...')
    logger.info(f'IPv4: {lan_ipv4}')
    logger.info(f'IPv6: {lan_ipv6}')
    if conn:
        conn.send(True)
        conn.close()
    udp_server.start()


if __name__ == '__main__':
    start()
    try:
        while True:
            sleep(1)
    except KeyboardInterrupt:
        pass
