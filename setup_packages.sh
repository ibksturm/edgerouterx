#! /bin/sh

opkg update

opkg install nano  luci-app-sqm  kmod-tcp-bbr  luci-app-bcp38 kmod-sched-cake kmod-ipt-nfqueue
opkg install kmod-nfnetlink-queue  kmod-sched-cake kmod-ipt-nfqueue kmod-nfnetlink-queue
opkg install iptables-mod-nfqueue libustream-openssl
opkg install ca-bundle ca-certificates ip6tables ip6tables-extra
opkg install kmod-ip6tables-extra kmod-ip6tables kmod-nf-ipt6  ip6tables-mod-nat 
opkg install tcpdump-mini libustream-openssl dnscypt-proxy2
