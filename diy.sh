# =========================
# OpenClash（确保版本一致）
# =========================
git clone --depth=1 https://github.com/vernesong/OpenClash.git package/luci-app-openclash

# =========================
# Tailscale（防止feeds缺失）
# =========================
git clone --depth=1 https://github.com/adyanth/openwrt-tailscale-enabler.git package/tailscale

# =========================
# Docker UI增强（可选）
# =========================
git clone --depth=1 https://github.com/lisaac/luci-app-dockerman.git package/luci-app-dockerman
