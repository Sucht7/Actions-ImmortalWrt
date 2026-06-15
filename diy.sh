#!/bin/bash
# 修改默认LAN IP 10.0.0.2
sed -i 's/192.168.1.1/10.0.0.2/g' package/base-files/files/bin/config_generate

# 设置网关指向主路由 10.0.0.1
sed -i '/set network.lan.gateway/d' package/base-files/files/bin/config_generate
echo "set network.lan.gateway='10.0.0.1'" >> package/base-files/files/bin/config_generate

# 关闭LAN DHCP（旁路由防冲突）
sed -i 's/set dhcp.lan.ignore=0/set dhcp.lan.ignore=1/' package/base-files/files/bin/config_generate

# 无线国家码设为 澳大利亚 AU
mkdir -p etc/config
echo "wireless country AU" >> etc/config/wireless
