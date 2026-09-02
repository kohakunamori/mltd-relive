from time import sleep

import netifaces
from dnslib.intercept import InterceptResolver
from dnslib.server import DNSLogger, DNSServer

from mltd.servers.config import config
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


def build_zone_record(lan_ipv4, lan_ipv6, asset_host=None):
    """Build DNS overrides used by corrected clients.

    API hostnames always resolve to the standalone server. A configured
    Desktop hybrid/local Asset hostname is also redirected to LAN, while its
    HTTPS certificate remains publicly trusted for that hostname.
    """
    hosts = list(_API_HOSTS)
    if asset_host:
        normalized = asset_host.rstrip('.').lower()
        if normalized and normalized not in hosts:
            hosts.append(normalized)

    records = []
    if lan_ipv4:
        records.extend(f'{host}. 60 IN A {lan_ipv4}' for host in hosts)
    if lan_ipv6:
        records.extend(f'{host}. 60 IN AAAA {lan_ipv6}' for host in hosts)
    return '\n'.join(records) + ('\n' if records else '')


def start(port=dns_port, conn=None):
    lan_ipv4, lan_ipv6 = get_lan_ips()
    asset_host = None
    if (config.asset_mode != 'remote' and not config.is_local
            and config.asset_public_host):
        asset_host = config.asset_public_host
    zone_record = build_zone_record(lan_ipv4, lan_ipv6, asset_host)

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
    if asset_host:
        logger.info(f'Asset DNS override: {asset_host} -> LAN')
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
