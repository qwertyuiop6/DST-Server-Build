#!/bin/bash

master='.klei/DoNotStarveTogether/MyDediServer/Master/'
cave='.klei/DoNotStarveTogether/MyDediServer/Caves/'

dst_dir=(${master} ${cave})

stop(){
	ps -ef|grep dontstarve|awk '{print $2}'|xargs kill -9
	if [[ -z `ps -ef | grep -v grep |grep -v "dst.sh"|grep "dontstarve"|sed -n '1P'|awk '{print $2}'` ]]; then
		echo -e "\033[32m ##: Dst server stop sucsess! \033[0m"
	fi
}

del(){
	stop
	for i in ${dst_dir[@]};
	do
		if [[ -d ${i}"save" ]]; then
			rm -r ${i}"save"&&rm -r `find ${i} -name "*.txt"` && rm -r ${i}"backup"
			echo -e "\033[32m ##: ${i}'s file already delete! \033[0m"
		fi
	done
}

goMaster(){
	cd ~/dst/bin

	if [[ -z `ps -ef | grep -v grep |grep -v "dst.sh"|grep "Master"|sed -n '1P'|awk '{print $2}'` ]]; then
		screen -dm sh overworld.sh && if [[ `echo $?` -eq 0 ]]; 
		then
			echo -e "\033[36m ##: Master sucsess to start! \033[0m"
		fi
	else
		echo -e "\033[31m !!! Master already started!!! \033[0m"
	fi
	
	# if [[ -z `ps -ef | grep -v grep |grep -v "dst.sh"|grep "Caves"|sed -n '1P'|awk '{print $2}'` ]]; then
	# 	screen -d sh cave.sh && if [[ `echo $?` -eq 0 ]]; then
	# 		echo -e "\033[32m ##: Cave sucsess to start! \033[0m"
	# 	fi
	# else
	# 	echo -e "\033[31m !!! Cave already started!!! \033[0m"
	# fi
	
}

goCaves(){
	cd ~/dst/bin
	
	if [[ -z `ps -ef | grep -v grep |grep -v "dst.sh"|grep "Caves"|sed -n '1P'|awk '{print $2}'` ]]; then
		screen -dm sh cave.sh && if [[ `echo $?` -eq 0 ]]; then
			echo -e "\033[36m ##: Cave sucsess to start! \033[0m"
		fi
	else
		echo -e "\033[31m !!! Cave already started!!! \033[0m"
	fi
}

go(){
	goMaster
	goCaves
}

reset(){
	del
	go
}

updst(){
	stop
	~/steamcmd/steamcmd.sh +login anonymous +force_install_dir ~/dst +app_update 343050 validate +quit
	if [[ `echo $?` -eq 0 ]]; then
		echo -e "\033[46;37m ##: Dst game update to new sucsess! \033[0m"
	fi
}

main(){

	echo -e "\033[42;30m ### what do you want to do? ### \033[0m"
	echo -e "\033[32m 0. \033[0m start master and cave server"
	echo -e "\033[32m 1. \033[0m only start master server"
	echo -e "\033[32m 2. \033[0m only start cave server"
	echo -e "\033[32m 3. \033[0m stop running server"
	echo -e "\033[32m 4. \033[0m delete server's saved file"                                                                                                 
	echo -e "\033[32m 5. \033[0m restart dst server"
	echo -e "\033[32m 6. \033[0m update dst game"

	read -p "Input your choose number: " choose
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
			5 ) reset
				;;
			6 ) updst
				;;
			* ) echo -e "\033[31mPlease enter the number before the following options!! \033[0m"
				main
				;;
		esac
	# else
	# 	echo "\033[31m please input the number of underlines! \033[0m"
	# 	main
	# fi
}

main
