#!/bin/bash
# 1. 修改OpenWrt默认IP为 10.0.0.2
sed -i 's/192.168.1.1/10.0.0.2/g' package/base-files/files/bin/config_generate

# 2. 设置网关指向iKuai主路由 10.0.0.1
sed -i '/set network.lan.gateway/d' package/base-files/files/bin/config_generate
echo "set network.lan.gateway='10.0.0.1'" >> package/base-files/files/bin/config_generate

# 3. 关闭LAN DHCP（旁路由必备，防止和主路由冲突）
sed -i 's/set dhcp.lan.ignore=0/set dhcp.lan.ignore=1/' package/base-files/files/bin/config_generate

# 4. WiFi国家码改为CN，保证功率、信道合规可用
sed -i 's/country=US/country/g' package/kernel/mac80211/files/lib/wireless/mac80211.sh
