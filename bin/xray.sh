#!/bin/bash

# 获取脚本所在目录
SCRIPT_DIR=$(dirname "$0")

# 切换到脚本所在目录
cd "$SCRIPT_DIR"

# 下载最新的 geoip.dat 和 geosite.dat 文件
wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat
wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat

# 下载最新的 xray 核心并解压
download_and_extract() {
    local arch=$1
    local newname=$2
    local url="https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-$arch.zip"
    local temp_dir=$(mktemp -d)
    
    # 下载 zip 文件到临时目录
    wget -q -O "$temp_dir/xray.zip" "$url"

    # 解压到临时目录
    unzip -q "$temp_dir/xray.zip" -d "$temp_dir"

    # 移动并重命名核心文件到脚本目录
    mv "$temp_dir/xray" "$SCRIPT_DIR/$newname"

    # 清理临时目录
    rm -rf "$temp_dir"
}

# 下载并解压不同架构的 xray 核心，并进行重命名
download_and_extract "64" "xray-linux-amd64"
download_and_extract "s390x" "xray-linux-s390x"
download_and_extract "arm64-v8a" "xray-linux-arm64"
download_and_extract "arm32-v7a" "xray-linux-arm32"
