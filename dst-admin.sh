#!/bin/bash

master="$HOME/.klei/DoNotStarveTogether/MyDediServer/Master/"
cave="$HOME/.klei/DoNotStarveTogether/MyDediServer/Caves/"

dst_dir=(${master} ${cave})
dst_name=("Master" "Caves")
dst_zh=("地上" "洞穴")
dst_sh=("overworld" "cave")

local_v=`cat ~/dst/version.txt`

# 查看状态
status(){
	if [[ -n `ps -ef | grep -v grep |grep -v "dst.sh"|grep ${dst_name[$1]}|sed -n '1P'|awk '{print $2}'` ]]; then
		echo -e "\033[36m ##: ${dst_zh[$1]}正常运行中~ \033[0m"
    else
        echo -e "\033[31m ${dst_zh[$1]}状态:关闭 \033[0m"
	fi
}

#　启动
start(){
    cd ~/dst/bin
    # dst=${dst_dir[$1]}
    if [[ -z `ps -ef | grep -v grep |grep -v "dst.sh"|grep ${dst_name[$1]}|sed -n '1P'|awk '{print $2}'` ]]; then
		screen -dm sh ${dst_sh[$1]}.sh && if [[ `echo $?` -eq 0 ]]; 
		then
			echo -e "\033[36m ##: ${dst_zh[$1]}启动成功~ \033[0m"
		fi
	else
		echo -e "\033[31m !!!${dst_zh[$1]}正在运行中!!! \033[0m"
	fi
}

# 停止
stop(){

	pid=`ps -ef | grep -v grep |grep -v "dst.sh"|grep ${dst_name[$1]}|sed -n '1P'|awk '{print $2}'`
	if [[ -z $pid ]]; then
		echo  -e "\033[32m ${dst_zh[$1]}状态:关闭 \033[0m"
	else
		kill -9 $pid
		echo  -e "\033[32m ##: ${dst_zh[$1]}已停止... \033[0m"	
	fi
												}
# 重启
restart(){
	stop $1
	start $1
}

# 重置
reset(){
	del $1
	start $1
}

#删除存档
del(){
	stop $1

	dir=${dst_dir[$1]}

	if test -d ${dir}/save
	then
		rm -r ${dir}/{save,backup}
		echo -e "\033[32m ##: ${dst_zh[$1]}文件删除完毕~ \033[0m"
	fi
}

# 更新游戏版本
updst(){
	type dst-v >/dev/null 2>&1&&remote_v=`dst-v -v`||remote_v=`~/DST-Server-Build/dst-v.sh -v`

	if [[ $remote_v -eq $local_v ]]; then
		echo -e "\033[32m!!饥荒游戏服务器已是最新版本!![v:$local_v] \033[0m"
		return
	fi

	if [ $1 ];then
		stop $1
	else
		stop 0
		stop 1
	fi

	modlink="$HOME/.klei/DoNotStarveTogether/MyDediServer/mods_setup.lua"
	modlua="$HOME/dst/mods/dedicated_server_mods_setup.lua"
	
	[ -f $modlink ]||ln $modlua $modlink

	~/steamcmd/steamcmd.sh +login anonymous +force_install_dir ~/dst +app_update 343050 validate +quit
	if [[ `echo $?` -eq 0 ]]; then
		echo -e "\033[46;37m ##: 饥荒游戏版本更新成功~ \033[0m"
	fi

	ln -f $modlink $modlua
}

main(){
	if [ $# -eq 0 ];then
		echo -e "\033[22;42;30m ###[ Don't Starve Togther 管理控制台 [v$local_v] ]### \033[0m"
		#echo -e "\033[32m 0. \033[0m 查看游戏服务器状态"
		echo -e "\033[1;32m 1. \033[0m 启动地上+洞穴"
		echo -e "\033[1;32m 2. \033[0m 停止游戏进程"
		echo -e "\033[1;32m 3. \033[0m 重启游戏进程,可以用来更新mod"
		echo -e "\033[1;32m 4. \033[0m 饥荒游戏服务器版本更新"                                                                                             
		echo -e "\033[1;32m 5. \033[0m 删除服务器游戏记录存档"
		echo -e "\033[1;32m 6. \033[0m 重置饥荒服务器,将删除游戏存档记录"
		echo -e "\033[32m PS:\033[0m (选项加 0或1可以单独操作地上或洞穴,如:10 启动地上)"
		echo -e "\033[40;36m当前饥荒服务器状态:\033[0m"
		main 0
		
		read -p "输入数字选项,回车确认: " choose
	else
		choose=$1
	fi
	
	case $choose in
		0 ) status 0
			status 1
			;;
		00 ) status 0
			;;
        01 ) status 1
            ;;

		1 ) start 0
            start 1
			;;
		10 ) start 0
			;;
        11 ) start 1
            ;;

		2 ) stop 0
			stop 1
			;;
		20 ) stop 0
			;;
		21 ) stop 1
			;;
		
		3 )	restart 0
			restart 1
			;;
		30 ) restart 0
			;;
		31 ) restart 1
			;;

		4 ) updst
			;;
		40 ) updst 0
			;;
		41 ) updst 1
			;;

		5 ) del 0
			del 1
			;;
        50 ) del 0
            ;;
        51 ) del 1
			;;
        
		6 ) reset 0
			reset 1
			;;
		60 ) reset 0
            ;;
		61 ) reset 1
			;;
		* ) echo -e "\033[1;31m请输入正确的数字指令!! \033[0m"
			main
			;;
	esac
}

type dst-v >/dev/null 2>&1&&(dst-v -s &)||~/DST-Server-Build/dst-v.sh -s &

main $1
