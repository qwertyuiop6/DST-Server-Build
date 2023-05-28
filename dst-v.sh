#!/bin/bash

server_version_file="$HOME/dst/version.txt"
check_url="https://forums.kleientertainment.com/game-updates/dst/"

# 获取最新版本号
getLastRelease() {
	local url=$1
	latest_version=$(curl -s $url | xmllint --html --xpath '//h3[contains(@class,"ipsType_sectionHead")][not(span[contains(@class,"negative")])]/text()' - 2>/dev/null | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sort -V | tail -n 1)
	echo "$latest_version"
}

main() {
	local local_v=$(cat $server_version_file)
	local remote_v=$(getLastRelease $check_url)

	if [[ $# -ne 0 ]] && [[ $1 == "-v" ]]; then
		echo $remote_v
		return
	fi

	if [[ "$remote_v" > "$local_v" ]]; then
		echo -e "\033[36m\n⭐ 饥荒服务器发现新版本[v:$remote_v] 请立即更新⭐\033[0m"
	elif [[ $# -eq 0 ]]; then
		echo -e "\e[31m !! 服务器游戏版本已是最新 !!\e[0m [v:\e[32m $local_v \e[0m] "
	fi
}

main "$@"
