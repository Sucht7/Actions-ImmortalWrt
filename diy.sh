#!/bin/bash
set -e

# ========= 1. 旁路由网络配置 (10.0.0.2 / 网关10.0.0.1 / 关闭DHCP) =========
sed -i 's/192.168.1.1/10.0.0.2/g' package/base-files/files/bin/config_generate
sed -i '/set network.lan.gateway/d' package/base-files/files/bin/config_generate
echo "set network.lan.gateway='10.0.0.1'" >> package/base-files/files/bin/config_generate
sed -i 's/set dhcp.lan.ignore=0/set dhcp.lan.ignore=1/' package/base-files/files/bin/config_generate

# ========= 2. 设置无线国家码 澳大利亚 AU =========
mkdir -p etc/config
echo "wireless country AU" >> etc/config/wireless

# ========= 3. 动态写入 feeds 源（修复 base 目录缺失，关键） =========
cat > feeds.conf << EOF
src-git base https://github.com/immortalwrt/openwrt.git;openwrt-23.05
src-git packages https://github.com/immortalwrt/packages.git;openwrt-23.05
src-git luci https://github.com/immortalwrt/luci.git;openwrt-23.05
src-git kenzo https://github.com/kenzok8/openwrt-packages
EOF

# ========= 4. 批量删除报错插件（根治所有依赖警告） =========
rm -rf feeds/packages/net/bmx7*
rm -rf feeds/luci/applications/luci-app-ahcp
rm -rf feeds/luci/applications/luci-app-babeld
rm -rf feeds/luci/applications/luci-app-bmx7
rm -rf feeds/luci/applications/luci-app-olsr*
rm -rf feeds/luci/protocols/luci-proto-batman-adv
rm -rf feeds/kenzo/luci-app-easymesh
rm -rf feeds/kenzo/luci-theme-alpha
rm -rf feeds/packages/utils/prometheus-node-exporter-lua

# ========= 5. 修复 busybox Config.in 检索失败 =========
find ./feeds/base/utils/busybox -name "Config.in" || true
