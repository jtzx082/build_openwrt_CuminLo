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
sed -i '/uci commit system/i\uci set system.@system[0].hostname='LoHome-Router'' package/lean/default-settings/files/zzz-default-settings
 
# 加入编译者信息
sed -i "s/OpenWrt /NewLuo Build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# 更新Go
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 22.x feeds/packages/lang/golang

# 更新; 每次获取最新 adguardhome 二进制
update_adguardhome() {
    adguardhome_version="0.108.0-b.57"
    #adguardhome_version=$(curl -s "https://api.github.com/repos/AdguardTeam/AdGuardHome/releases" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g' | awk -F "v" '{print $2}')
    sed -ri "s/(PKG_VERSION:=)[^\"]*/\1$adguardhome_version/" feeds/packages/net/adguardhome/Makefile
    sed -i 's/release/beta/g' feeds/packages/net/adguardhome/Makefile
    sed -i 's/.*PKG_MIRROR_HASH.*/#&/' feeds/packages/net/adguardhome/Makefile
    sed -i '/init/d' feeds/packages/net/adguardhome/Makefile
}
update_adguardhome

# 更新 mosdns
update_mosdns() {
    find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
    find ./ | grep Makefile | grep mosdns | xargs rm -f

    git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
    git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
}
update_mosdns
