#!/bin/bash
#==================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#==================================================

sed -i '1i src-git nikki https://github.com/nikkinikki-org/OpenWrt-nikki.git' feeds.conf.default
sed -i '2i src-git netspeedtest https://github.com/sirpdboy/netspeedtest' feeds.conf.default
sed -i '3i src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '4i src-git small https://github.com/kenzok8/small' feeds.conf.default