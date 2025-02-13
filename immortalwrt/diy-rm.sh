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
    # rm -rf ./feeds/kenzo/filebrowser
    # rm -rf ./feeds/kenzo/luci-app-filebrowser
    rm -rf feeds/luci/applications/luci-app-mosdns
    rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray*,v2ray*,sing*,smartdns}
    rm -rf feeds/packages/utils/v2dat
}
delete_conflict_package