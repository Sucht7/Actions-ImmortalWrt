#!/bin/bash
# 旁路由IP 10.0.0.2
sed -i 's/192.168.1.1/10.0.0.2/g' package/base-files/files/bin/config_generate
# 网关 10.0.0.1
sed -i '/set network.lan.gateway/d' package/base-files/files/bin/config_generate
echo "set network.lan.gateway='10.0.0.1'" >> package/base-files/files/bin/config_generate
# 关闭DHCP
sed -i 's/set dhcp.lan.ignore=0/set dhcp.lan.ignore=1/' package/base-files/files/bin/config_generate
# 无线国家 AU
mkdir -p etc/config
echo "wireless country AU" >> etc/config/wireless
