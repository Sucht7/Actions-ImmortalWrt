#!/bin/bash
set -e

# ========= 兜底：强制创建 busybox 目录，修复 glob 检索失败 =========
mkdir -p feeds/base/utils/busybox
touch feeds/base/utils/busybox/Config.in

# ========= 1. 旁路由网络配置 10.0.0.2 / 网关10.0.0.1 / 关闭DHCP =========
sed -i 's/192.168.1.1/10.0.0.2/g' package/base-files/files/bin/config_generate
sed -i '/set network.lan.gateway/d' package/base-files/files/bin/config_generate
echo "set network.lan.gateway='10.0.0.1'" >> package/base-files/files/bin/config_generate
sed -i 's/set dhcp.lan.ignore=0/set dhcp.lan.ignore=1/' package/base-files/files/bin/config_generate

# ========= 2. 无线国家码 设置澳大利亚 AU =========
mkdir -p etc/config
echo "wireless country AU" >> etc/config/wireless

# ========= 3. 动态写入合法 feeds 源 =========
cat > feeds.conf << EOF
src-git base https://github.com/immortalwrt/openwrt.git;openwrt-23.05
src-git packages https://github.com/immortalwrt/packages.git;openwrt-23.05
src-git luci https://github.com/immortalwrt/luci.git;openwrt-23.05
src-git kenzo https://github.com/kenzok8/openwrt-packages
EOF

# ========= 4. 彻底删除所有冲突/报错包（全覆盖） =========
rm -rf feeds/packages/net/bmx7*
rm -rf feeds/luci/applications/luci-app-ahcp
rm -rf feeds/luci/applications/luci-app-babeld
rm -rf feeds/luci/applications/luci-app-bmx7
rm -rf feeds/luci/applications/luci-app-olsr*
rm -rf feeds/luci/protocols/luci-proto-batman-adv
rm -rf feeds/kenzo/luci-app-easymesh
rm -rf feeds/kenzo/luci-theme-alpha
# 专项删除 prometheus 解决残留告警
rm -rf feeds/packages/utils/prometheus-node-exporter-lua

# ========= 5. 清理旧索引 =========
rm -rf feeds/*.index
