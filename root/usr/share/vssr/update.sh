#!/bin/sh

chnroute_data=$(wget -O- -t 3 -T 3 http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest)
[ $? -eq 0 ] && {
    echo "$chnroute_data" | grep ipv4 | grep CN | awk -F\| '{ printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > /tmp/china_ssr.txt
}

if [ -s "/tmp/china_vssr.txt" ];then
  if ( ! cmp -s /tmp/china_vssr.txt /etc/china_vssr.txt );then
    mv /tmp/china_vssr.txt /etc/china_vssr.txt
  fi
fi

/usr/share/vssr/chinaipset.sh

wget-ssl --no-check-certificate https://cdn.jsdelivr.net/gh/gfwlist/gfwlist/gfwlist.txt -O /tmp/gfw.b64
/usr/bin/vssr-gfw

if [ -s "/tmp/gfwnew.txt" ];then
  if ( ! cmp -s /tmp/gfwnew.txt /etc/dnsmasq.d/gfw_list.conf );then
    mv /tmp/gfwnew.txt /etc/dnsmasq.d/gfw_list.conf
    echo "copy"
  fi
fi

/etc/init.d/vssr restart