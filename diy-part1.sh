#!/bin/bash
#=============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=============================================================

# fw876/helloworld
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Lienol/openwrt-package
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

# Modify Default Theme
sed -i '/exit 0/i uci batch <<-EOF' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i    set luci.themes.Argon=/luci-static/argon' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i    set luci.main.mediaurlbase=/luci-static/argon' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i    commit luci' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i EOF' package/lean/default-settings/files/zzz-default-settings

# DownLoad OpenClash
mkdir package/luci-app-openclash
cd package/luci-app-openclash
git init
git remote add -f origin https://github.com/vernesong/OpenClash.git
git config core.sparsecheckout true
echo "luci-app-openclash" >> .git/info/sparse-checkout
git pull origin master
git branch --set-upstream-to=origin/master master
cd -
# integration clash core 实现编译更新后直接可用，不用手动下载clash内核
curl -sL -m 30 --retry 2 https://github.com/vernesong/OpenClash/releases/download/Clash/clash-linux-amd64.tar.gz -o /tmp/clash.tar.gz
tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p package/luci-app-openclash/luci-app-openclash/files/etc/openclash/core
mv /tmp/clash package/luci-app-openclash/luci-app-openclash/files/etc/openclash/core/clash >/dev/null 2>&1
rm -rf /tmp/clash.tar.gz >/dev/null 2>&1
