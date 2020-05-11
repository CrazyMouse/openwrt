#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

# Modify default IP
sed -i 's/192.168.1.1/10.10.10.99/g' package/base-files/files/bin/config_generate

# Modify Host Name
sed -i '/uci commit system/i uci set system.@system[0].hostname=CrazyWrt'  package/lean/default-settings/files/zzz-default-settings

#Backup OpenClash cofig
echo '/etc/openclash/' >> package/base-files/files/etc/sysupgrade.conf

# Update Luci theme argon  
rm -rf package/lean/luci-theme-argon  
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon

