#!/bin/bash

master='.klei/DoNotStarveTogether/MyDediServer/Master/'
cave='.klei/DoNotStarveTogether/MyDediServer/Caves/'

dst_dir=(${master} ${cave})

stop(){
	ps -ef|grep dontstarve|awk '{print $2}'|xargs kill -9
	if [[ -z `ps -ef | grep -v grep |grep -v "dst.sh"|grep "dontstarve"|sed -n '1P'|awk '{print $2}'` ]]; then
		echo -e "\033[32m ##: 饥荒服务器停止成功!! \033[0m"
	fi
}

del(){
	stop
	for i in ${dst_dir[@]};
	do
		if [[ -d ${i}"save" ]]; then
			rm -r ${i}"save"&&rm -r `find ${i} -name "*.txt"` && rm -r ${i}"backup"
			echo -e "\033[32m ##: ${i}'s 文件已经删除! \033[0m"
		fi
	done
}

goMaster(){
	cd ~/dst/bin

	if [[ -z `ps -ef | grep -v grep |grep -v "dst.sh"|grep "Master"|sed -n '1P'|awk '{print $2}'` ]]; then
		screen -dm sh overworld.sh && if [[ `echo $?` -eq 0 ]]; 
		then
			echo -e "\033[36m ##: 地上成功启动... \033[0m"
		fi
	else
		echo -e "\033[31m !!! 地上正在运行中!!! \033[0m"
	fi
	
}

goCaves(){
	cd ~/dst/bin
	
	if [[ -z `ps -ef | grep -v grep |grep -v "dst.sh"|grep "Caves"|sed -n '1P'|awk '{print $2}'` ]]; then
		screen -dm sh cave.sh && if [[ `echo $?` -eq 0 ]]; then
			echo -e "\033[36m ##: 洞穴启动成功... \033[0m"
		fi
	else
		echo -e "\033[31m !!!洞穴正在运行中!!! \033[0m"
	fi
}

go(){
	goMaster
	goCaves
}

restart(){
	stop
	go
}

reset(){
	del
	go
}

updst(){
	stop
	~/steamcmd/steamcmd.sh +login anonymous +force_install_dir ~/dst +app_update 343050 validate +quit
	if [[ `echo $?` -eq 0 ]]; then
		echo -e "\033[46;37m ##: 饥荒游戏版本更新成功!! \033[0m"
	fi
}

main(){

	echo -e "\033[42;30m ### 来做个选 ♂ 择吧 (输入数字,回车确认) ### \033[0m"
	echo -e "\033[32m 0. \033[0m 启动地上+洞穴"
	echo -e "\033[32m 1. \033[0m 只启动地上"
	echo -e "\033[32m 2. \033[0m 只启动洞穴"
	echo -e "\033[32m 3. \033[0m 停止饥荒游戏进程"
	echo -e "\033[32m 4. \033[0m 删除游戏存档记录"                                                                                             
	echo -e "\033[32m 5. \033[0m 重启游戏(非重置),可以更新mod"
	echo -e "\033[32m 6. \033[0m 重置饥荒游戏,将删除游戏存档记录"
	echo -e "\033[32m 7. \033[0m 更新饥荒游戏版本"

	read -p "输入数字,回车确认选择 " choose
	# if [[ $choose -gt 0 ]]; then
		case $choose in
			0 ) go
				;;
			1 ) goMaster
				;;
			2 ) goCaves
				;;
			3 ) stop
				;;
			4 ) del
				;;
			5 ) restart
				;;
			6 ) reset
				;;
			7 ) updst
				;;
			* ) echo -e "\033[31m 请输入下列正确的数字选项!! \033[0m"
				main
				;;
		esac
	# else
	# 	echo "\033[31m please input the number of underlines! \033[0m"
	# 	main
	# fi
}

main
