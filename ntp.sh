#! /bin/sh

# Intercept DNS traffic
uci -q delete firewall.dns_int
uci set firewall.dns_int="redirect"
uci set firewall.dns_int.name="Intercept-DNS"
uci set firewall.dns_int.src="lan"
uci set firewall.dns_int.src_dport="123"
uci set firewall.dns_int.family="ipv4"
uci set firewall.dns_int.proto="tcpudp"
uci set firewall.dns_int.target="DNAT"
uci commit firewall
/etc/init.d/firewall restart


# Enable NAT6
opkg update
opkg install kmod-ipt-nat6
cat << EOF > /etc/firewall.nat6
iptables-save -t nat \
| sed -e "/\s[DS]NAT\s/d;/\sMASQUERADE$/d" \
| ip6tables-restore -T nat
EOF
uci -q delete firewall.nat6
uci set firewall.nat6="include"
uci set firewall.nat6.path="/etc/firewall.nat6"
uci set firewall.nat6.reload="1"
uci commit firewall
/etc/init.d/firewall restart

uci -q delete system.ntp.server
uci add_list system.ntp.server="0.ch.pool.ntp.org"
uci add_list system.ntp.server="1.ch.pool.ntp.org"
uci add_list system.ntp.server="2.ch.pool.ntp.org"
uci add_list system.ntp.server="3.ch.pool.ntp.org"
uci commit system
/etc/init.d/sysntpd restart
