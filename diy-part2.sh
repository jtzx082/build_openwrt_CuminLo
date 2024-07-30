#!/bin/bash
#==================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#==================================================
# Modify default IP
sed -i 's/192.168.1.1/192.168.50.1/g' package/base-files/files/bin/config_generate

# 取消原主题luci-theme-bootstrap 为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap

# 修改 netgear 为默认主题
sed -i 's/luci-theme-bootstrap/luci-theme-netgear/g' feeds/luci/collections/luci/Makefile

# 删除原默认主题
# rm -rf package/lean/luci-theme-bootstrap

# 修改默认主机名
sed -i '/uci commit system/i\uci set system.@system[0].hostname='Soft_Router'' package/lean/default-settings/files/zzz-default-settings
 
# 加入编译者信息
sed -i "s/OpenWrt /NewLuo Build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# 更新Go
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang