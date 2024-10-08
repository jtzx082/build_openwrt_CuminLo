#!/bin/bash
#==================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#==================================================
# Modify default IP
sed -i 's/192.168.1.1/192.168.50.1/g' package/base-files/files/bin/config_generate

# 修改 netgear 为默认主题
#sed -i 's/luci-theme-bootstrap/luci-theme-netgear/g' feeds/luci/collections/luci/Makefile

# 更新Go
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 23.x feeds/packages/lang/golang

# 更新; 每次获取最新 adguardhome 二进制
update_adguardhome() {
    adguardhome_version=$(curl -s "https://api.github.com/repos/AdguardTeam/AdGuardHome/releases" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g' | awk -F "v" '{print $2}')
    sed -ri "s/(PKG_VERSION:=)[^\"]*/\1$adguardhome_version/" feeds/packages/net/adguardhome/Makefile
    sed -i 's/release/beta/g' feeds/packages/net/adguardhome/Makefile
    sed -i 's/.*PKG_MIRROR_HASH.*/#&/' feeds/packages/net/adguardhome/Makefile
    # sed -i '/init/d' feeds/packages/net/adguardhome/Makefile
}
update_adguardhome

#删除冲突的包
delete_conflict_package() {
    # filebrowser
    rm -rf ./feeds/kenzo/filebrowser
    rm -rf ./feeds/kenzo/luci-app-filebrowser
}
delete_conflict_package