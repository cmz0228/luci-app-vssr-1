#!/bin/sh

mkdir -p /tmp/dnsmasq.d

awk '!/^$/&&!/^#/{printf("ipset=/.%s/'"gfwlist"'\n",$0)}' /etc/config/gfwlist .list > /tmp/dnsmasq.d/custom_forward.conf
awk '!/^$/&&!/^#/{printf("server=/.%s/'"127.0.0.1#5335"'\n",$0)}' /etc/config/gfwlist .list >> /tmp/dnsmasq.d/custom_forward.conf

awk '!/^$/&&!/^#/{printf("ipset=/.%s/'"blacklist"'\n",$0)}' /etc/config/black.list > /tmp/dnsmasq.ssr/blacklist_forward.conf
awk '!/^$/&&!/^#/{printf("server=/.%s/'"127.0.0.1#5335"'\n",$0)}' /etc/config/blacklist .list >> /tmp/dnsmasq.d/blacklist_forward.conf

awk '!/^$/&&!/^#/{printf("ipset=/.%s/'"whitelist"'\n",$0)}' /etc/config/whitelist .list > /tmp/dnsmasq.d/whitelist_forward.conf
