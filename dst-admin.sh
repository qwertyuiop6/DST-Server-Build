#!/bin/bash
servers="$HOME/.klei/DoNotStarveTogether"
cluster="$servers/MyDediServer"
master="$cluster/Master"
cave="$cluster/Caves"

dst_dir=(${master} ${cave})
dst_name=("Master" "Caves")
dst_zh=("地上" "洞穴")
dst_sh=("overworld" "cave")

local_v=`cat ~/dst/version.txt`

if [ `screen -ls | grep -c Dead` -gt 0 ]
	then screen -wipe 
fi


# 查看状态
status(){
	if [[ ${dst_live[$1]} > 0 ]]; then
		echo -e "\e[36m ${dst_zh[$1]}:⭐运行中⭐ \e[0m"
    else
        echo -e "\e[31m ${dst_zh[$1]}:关闭 \e[0m"
	fi
}

#　启动
start(){
	cd ~/dst/bin
    if [[ ${dst_live[$1]} -eq 0 ]]; then
		screen -S "DST_${dst_name[$1]}" -dm sh ${dst_sh[$1]}.sh && if [[ `echo $?` -eq 0 ]];
		then
			[ -f ${dst_dir[$1]}/chat.txt.tmp ]&&mv ${dst_dir[$1]}/chat.txt.tmp ${dst_dir[$1]}/server_chat_log.txt
			echo -e "\e[36m ##: ${dst_zh[$1]}启动成功~ \e[0m"
		fi
	else
		echo -e "\e[31m !!!${dst_zh[$1]}正在运行中!!! \e[0m"
	fi
}

# 停止
stop(){
	if [[ ${dst_live[$1]} -gt 0 ]];then
		screen -S DST_${dst_name[$1]} -p 0 -X stuff "c_shutdown()$(printf \\r)"
		echo  -e "\e[32m ##: ${dst_zh[$1]}已停止... \e[0m"
		sleep 2s
		cp ${dst_dir[$1]}/server_chat_log.txt ${dst_dir[$1]}/chat.txt.tmp		
	else
		echo  -e "\e[32m ${dst_zh[$1]}状态:关闭 \e[0m"
	fi
												}
# 重启
restart(){
	stop $1
	update_status
	start $1
}

# 重置
reset(){
	now=`date '+%Y-%m-%d'`
	bak=${servers}/${now}.reset.bak
	if [ ! -d $bak ];then
		cp -r $cluster $bak
		echo -e "\e[32m 存档文件已备份于:$bak \e[0m"
	fi

	del $1
	update_status
	start $1
	# if [[ $Master_live > 0 ]]; then
	#     screen -S "DST_Master" -p 0 -X stuff "c_regenerateworld()$(printf \\r)"
	# fi
	# if [[ $Caves_live > 0 ]]; then
	#     screen -S "DST_Caves" -p 0 -X stuff "c_regenerateworld()$(printf \\r)"
	# fi
	# echo "\e[35m正在重置当前世界。。。请稍候。。。\e[0m"
}

#删除当前存档
del(){
	stop $1
	dir=${dst_dir[$1]}

	if test -d ${dir}/save
	then
		rm -r ${dir}/{save,backup,*.txt,*.tmp}
		echo -e "\e[32m ##: ${dst_zh[$1]}存档文件删除完毕~ \e[0m"
	fi
}

# 更新游戏版本
updst(){
	type dst-v >/dev/null 2>&1&&remote_v=`dst-v -v`||remote_v=`~/DST-Server-Build/dst-v.sh -v`

	if [[ $remote_v -eq $local_v ]]; then
		echo -e "\e[32m!!饥荒游戏服务器已是最新版本!![v:$local_v] \e[0m"
		return
	fi

	if [ $1 ];then
		stop $1
		dir=${dst_dir[$1]}
		cp $dir/server_chat_log.txt $dir/chat.txt.tmp
	else
		stop 0
		stop 1
		dir=${dst_dir[0]}
		cp $dir/server_chat_log.txt $dir/chat.txt.tmp
	fi

	modlink="$cluster/mods_setup.lua"
	modlua="$HOME/dst/mods/dedicated_server_mods_setup.lua"
	
	[ -f $modlink ]||ln $modlua $modlink

	steamcmd +force_install_dir ../../dst +login anonymous  +app_update 343050 validate +quit
	if [[ `echo $?` -eq 0 ]]; then
		echo -e "\e[36m ⭐饥荒游戏版本更新成功 version:[`cat ~/dst/version.txt`] ⭐ \e[0m"
	fi

	ln -f $modlink $modlua

	update_status

	if [ $1 ];then
		start $1
	else
		start 0
		start 1
	fi
}

#回档
rollback(){
	if [ $Master_live -eq 0 ];then
		echo -n "---------服务器关闭中----------"
		return 
	fi
	if [ ! $1 ];then 
		return 
	fi
	if [[ $Master_live > 0 ]]; then
		screen -S "DST_Master" -p 0 -X stuff "c_rollback($rollbackday)$(printf \\r)"
	fi
	if [[ $Caves_live > 0 ]]; then
	    screen -S "DST_Caves" -p 0 -X stuff "c_rollback($rollbackday)$(printf \\r)"
	fi
	echo -e "\e[32m 已回档$rollbackday 天!\e[0m"
}

#重新生成世界
regenerate(){
	if [ $Master_live -eq 0 ];then
		echo -n "---------服务器关闭中----------"
		return 
	fi
	now=`date '+%Y-%m-%d'`
	cp -r $cluster ${servers}/${now}.regen.bak
	screen -S DST_Master -p 0 -X stuff "c_regenerateworld()$(printf \\r)"
	# screen -S DST_${dst_name[$1]} -p 0 -X stuff "c_regenerateworld()$(printf \\r)"
}

#公告
announce(){
	if [ $Master_live -eq 0 ];then
		echo -e "---------服务器关闭中----------"
		return 
	fi
	screen -S DST_Master -p 0 -X stuff "c_announce(\"$1\")$(printf \\r)"
	echo -e "\e[92m信息已发送√ \e[0m"
}



getworldstate(){
    presentseason=""
	presentday=""
	presentcycles=""
	presentphase=""
	presentmoonphase=""
	presentrain=""
	presentsnow=""
	presenttemperature=""

	if [[ $Master_live > 0 ]]; then   									        
	    datatime=$( date +%s%3N )	
		screen -S DST_Master -p 0 -X stuff "print(\"\" .. TheWorld.net.components.seasons:GetDebugString() .. \" $datatime print\")$(printf \\r)"
		screen -S DST_Master -p 0 -X stuff "print(\"\" .. TheWorld.components.worldstate.data.phase .. \" $datatime phase\")$(printf \\r)"
		screen -S DST_Master -p 0 -X stuff "print(\"\" .. TheWorld.components.worldstate.data.moonphase .. \" $datatime moonphase\")$(printf \\r)"
		screen -S DST_Master -p 0 -X stuff "print(TheWorld.components.worldstate.data.temperature .. \" $datatime temperature\")$(printf \\r)"
		screen -S DST_Master -p 0 -X stuff "print(TheWorld.components.worldstate.data.cycles .. \" $datatime cycles\")$(printf \\r)"
		screen -S DST_Master -p 0 -X stuff "print(\"$datatime:rain:\",TheWorld.components.worldstate.data.israining)$(printf \\r)"
		screen -S DST_Master -p 0 -X stuff "print(\"$datatime:snow:\",TheWorld.components.worldstate.data.issnowing)$(printf \\r)"
		
		# sleep 1

		master_log=$master/server_log.txt
	    presentseason=$( grep $master_log -e "$datatime print" | cut -d ' ' -f2 | tail -n +2 )
		presentday=$( grep $master_log -e "$datatime print" | cut -d ' ' -f3 | tail -n +2 )
		presentphase=$( grep $master_log -e "$datatime phase" | cut -d ' ' -f2 | tail -n +2 )
		presentmoonphase=$( grep $master_log -e "$datatime moonphase" | cut -d ' ' -f2 | tail -n +2 )
		presenttemperature=$( grep $master_log -e "$datatime temperature" | cut -d ' ' -f2 | tail -n +2 )
		presentrain=$( grep $master_log -e "$datatime:rain" | cut -d ':' -f6 | tail -n +2 )
		presentsnow=$( grep $master_log -e "$datatime:snow" | cut -d ':' -f6 | tail -n +2 | cut -d ' ' -f2 )
		presentcycles=$( grep $master_log -e "$datatime cycles" | cut -d ' ' -f2 | tail -n +2 )
		
		if [[ "$presentseason" == "autumn" ]]; then
		    presentseason="秋天"
		fi
		if [[ "$presentseason" == "spring" ]]; then
		    presentseason="春天"
		fi
		if [[ "$presentseason" == "summer" ]]; then
		    presentseason="夏天"
		fi
		if [[ "$presentseason" == "winter" ]]; then
		    presentseason="冬天"
		fi
		
		if [[ "$presentphase" == "day" ]]; then
		    presentphase="白天"
		fi
		if [[ "$presentphase" == "dusk" ]]; then
		    presentphase="黄昏"
		fi
		if [[ "$presentphase" == "night" ]]; then
		    presentphase="黑夜"
		fi
		
		if [[ "$presentmoonphase" == "new" ]]; then
		    presentmoonphase="新月"
		fi
		if [[ "$presentmoonphase" == "full" ]]; then
		    presentmoonphase="满月"
		fi
		if [[ "$presentmoonphase" == "threequarter" || "$presentmoonphase" == "quarter" || "$presentmoonphase" == "half" ]]; then
		    presentmoonphase="缺月"
		fi
		
		presenttemperature=${presenttemperature%.*}
		
		if [[ $( echo "$presentrain" | grep -c "true" ) > 0 ]]; then
		    presentrain="下雨"
		fi
		if [[ $( echo "$presentrain" | grep -c "false" ) > 0 ]]; then
		    presentrain="无雨"
		fi
		
		if [[ $( echo "$presentsnow" | grep -c "true" ) > 0 ]]; then
		    presentsnow="下雪"
		fi
		if [[ $( echo "$presentsnow" | grep -c "false" ) > 0 ]]; then
		    presentsnow="无雪"
		fi
	fi
	
}
getworldname(){
	maxplayer=$( grep "$cluster/cluster.ini" -e "max_players =" | cut -d ' ' -f3 )
    world_name=$( grep "$cluster/cluster.ini" -e "cluster_name =" | cut -d ' ' -f3-20 )
	passkey=$( grep "$cluster/cluster.ini" -e "cluster_password =" | cut -d ' ' -f3 )
	gamemode=$( grep "$cluster/cluster.ini" -e "game_mode =" | cut -d ' ' -f3 )
	if [[ "$passkey" == "" ]]; then
	    passkey="无"
	fi
	if [[ "$gamemode" == "endless" ]]; then
	    gamemode="无尽模式"
	fi
	if [[ "$gamemode" == "survival" ]]; then
	    gamemode="生存模式"
	fi
	if [[ "$gamemode" == "wilderness" ]]; then
	    gamemode="荒野模式"
	fi
}
getplayernumber(){	
    # number=0
	if [[ $Master_live > 0 ]]; then
	    allplayersnumber=$( date +%s%3N )
	    screen -S DST_Master -p 0 -X stuff "print(\"AllPlayersNumber \" .. (table.getn(TheNet:GetClientTable())-1) .. \" $allplayersnumber\")$(printf \\r)"
	    sleep 1
	    number=$( grep $master_log -e "$allplayersnumber" | cut -f3 -d ' ' | tail -n +2 )
	fi
}
getplayerlist(){
	if [ $Master_live -gt 0 ] ;then
		allplayerslist=$( date +%s%3N )
		screen -S DST_Master -p 0 -X stuff "for i, v in ipairs(TheNet:GetClientTable()) do  print(string.format(\"playerlist %s %d. ID:[%s] 玩家:\\\\\e[36m[%s]\\\\\e[0m 角色:%s\", $allplayerslist, i-1, v.userid, v.name, v.prefab )) end$(printf \\r)"
		sleep 1
		playerlist=$( grep $master_log -e "playerlist $allplayerslist" | cut -d ' ' -f 4-15 | tail -n +2)
			if [ ! $Master_live = "" ] ;then
				echo $playerlist > $cluster/playerlist.txt
			fi
	fi
}

serverinfo(){
    echo -e "\e[35m请稍等,正在获取世界和玩家信息........\e[0m"
	# getpresentcluster
	# getpresentserver

	getworldname
	getworldstate
	getplayernumber
	getplayerlist

    # echo -e "\e[33m当前服务器开启的世界:$server\e[0m"
	echo -e "\e[92m------------------世界信息--------------------\e[0m"
	echo -e "\e[33m房名:【$world_name】 密码: 【$passkey】 人数: \e[36m【$number/$maxplayer】\e[0m\e[33m【$gamemode】\e[0m"
	echo -e "\e[33m天数:【$presentcycles】天 【$presentseason】的第【$presentday】天\e[0m"
	echo -e "\e[33m现在:【$presentphase】【$presentmoonphase】【$presentrain】【$presentsnow】【$presenttemperature°C】\e[0m"
	
	if [[ ! "$playerlist" = "" ]]; then
		echo -e "\e[92m⭐服务器玩家列表⭐\e[0m"
		# echo -e "\e[92m========================================================\e[0m"
		echo -e "$playerlist"
		# echo -e "\e[92m========================================================\e[0m"
		# echo "$list" > $HOME/.klei/playerlist.txt
	fi
	# if [[ master_live > 0 ]]; then
	# 	getmonster
	# 	echo -e "\e[33m猪人火炬:【$pigtorch】个  海象巢:【$walrus_camp】个  触手怪:【$tentacle】个  蜘蛛巢:【$spiderden】个\e[0m"
	# 	echo -e "\e[33m高脚鸟巢:【$tallbirdnest】个  齿轮怪:【$chilun】个  猎犬丘:【$houndmound】个  芦苇:【$reeds】株  墓地:【$mudi】个\e[0m"
	# fi
	
    echo -e "\e[92m----------------------------------------------\e[0m"
}

checkserver(){
	screen -ls
	if [[ $Master_live >0 || $Caves_live >0 ]]; then
		echo -e "\e[36m 即将进入世界控制台.....\e[0m"
		sleep 1
	    if [[ $Master_live > 0 ]]; then
	        screen -r DST_Master
	    else 
	        screen -r DST_Caves
	    fi
	else
	    echo -e "\e[31m !!!游戏服务器尚未开启!!! \e[0m"
		sleep 2 
		main
	fi
}

update_status(){
	Master_live=`screen -ls | grep -c DST_Master`
	Caves_live=`screen -ls | grep -c DST_Caves`
	dst_live=($Master_live $Caves_live)
}
main(){
	update_status
	if [ $# -eq 0 ];then
		echo -e "\e[22;42;30m ###====[ Don't Starve Togther 管理控制台 [v$local_v] ]====### \e[0m"
		echo -e "\e[1;32m 0. \e[0m 查看游戏服务器"
		echo -e "\e[1;32m 1. \e[0m 启动地上+洞穴"
		echo -e "\e[1;32m 2. \e[0m 停止游戏进程"
		echo -e "\e[1;32m 3. \e[0m 重启游戏进程,可以用来更新mod"
		echo -e "\e[1;32m 4. \e[0m 饥荒游戏服务器版本更新"                                                                                             
		echo -e "\e[1;32m 5. \e[0m 删除服务器游戏存档"
		echo -e "\e[1;32m 6. \e[0m 重置饥荒服务器,将删除游戏存档"
		echo -e "\e[32m PS:\e[0m (选项加 0或1可以单独操作地上或洞穴,如:10 启动地上)"
		
		echo -e "\e[36m----饥荒服务器状态-----\e[0m"
		main 0
		echo -e "\e[36m-----------------------\e[0m"
		
		if [[ $Master_live > 0 ]];then
			read -p "服务器运行中,是否获取世界和玩家信息? [y/n] " -n 1
			echo ""
			if [[ $REPLY =~ ^[Yy]$ ]];then
				serverinfo
			fi
		fi
		read -p "输入选项前数字,回车确认操作: " choose
	else
		choose=$1
	fi
	
	case $choose in
		0 )status 0
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
		rb ) read -p "请输入你要回档的天数(1~5): " rollbackday
			rollback $rollbackday
			;;
		rg ) regenerate
			;;
		an ) read -p "请输入公告内容: " announcement
			announce $announcement
			;;
		x ) checkserver 
			main
			;;
		* ) echo -e "\e[1;31m请输入正确的数字指令!! \e[0m"
			main
			;;
	esac
}

type dst-v >/dev/null 2>&1&&(dst-v -s &)||~/DST-Server-Build/dst-v.sh -s &

main $1
