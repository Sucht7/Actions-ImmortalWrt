#!/bin/bash
# 修改默认LAN IP为 10.0.0.2
sed -i 's/192.168.1.1/10.0.0.2/g' package/base-files/files/bin/config_generate

# 追加网关指向主路由 10.0.0.1
sed -i '/set network.lan.gateway/d' package/base-files/files/bin/config_generate
echo "set network.lan.gateway='10.0.0.1'" >> package/base-files/files/bin/config_generate

# 关闭LAN DHCP（旁路由必备）
sed -i 's/set dhcp.lan.ignore=0/set dhcp.lan.ignore=1/' package/base-files/files/bin/config_generate

# ========= 已删除 mac80211.sh 相关失效命令 =========
