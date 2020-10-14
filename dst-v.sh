#!/bin/bash

local_v=`cat ~/dst/version.txt`
remote_v=`python3 ~/DST-Server-Build/getRelease.py`
main(){
	if [ $# -ne 0 ]&&[ $1 == -v ];then
		echo $remote_v
		return
	fi
	if [ $remote_v -gt $local_v ];then
		echo -e "\033[36m\n⭐ 饥荒服务器发现版本更新[v:$remote_v] ⭐\033[0m"
	elif [ $# -eq 0 ];then
		echo -e "\033[32m !!服务器游戏版本已是最新!![v:$local_v] \033[0m"
	fi
}

main $1