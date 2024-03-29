#!/bin/bash
dst_install=$HOME/dst
servers="$HOME/.klei/DoNotStarveTogether"

cluster_names=$(find $servers -maxdepth 1 -mindepth 1 -type d)
cluster_count=$(find $servers -maxdepth 1 -mindepth 1 -type d | wc -l)

if [ $cluster_count -eq 1 ]; then
	cluster_name=$cluster_names
else
	for folder in $cluster_names; do
		c=$(basename $folder)
		if [ -z $first ]; then
			first=$c
		fi
		echo $c
	done
	echo -e "\033[32m请输入您要操作的存档名称(默认为\033[36m $first \033[0m\033[32m),回车确认:\033[0m"
	read cluster_name
	if [ -z $cluster_name ]; then
		cluster_name=$first
	fi

fi

cluster="$servers/$cluster_name"
if [ ! -d $cluster ]; then
	echo -e "\e[1;31m请输入正确的存档名称!! \e[0m"
	exit 1
fi

master="$cluster/Master"
cave="$cluster/Caves"

dst_dir=(${master} ${cave})
dst_name=("Master" "Caves")
dst_zh=("地上" "洞穴")
dst_sh=("overworld" "cave")

local_v=$(cat $dst_install/version.txt)
script_dir="$(dirname "$(readlink -f "$0")")"

if [ $(screen -ls | grep -c Dead) -gt 0 ]; then
	screen -wipe
fi

# 查看状态
status() {
	if [[ ${dst_live[$1]} > 0 ]]; then
		echo -e "\e[36m ${dst_zh[$1]}: ⭐ 运行中 ⭐ \e[0m"
	else
		echo -e "\e[31m ${dst_zh[$1]}: x 关闭 x\e[0m"
	fi
}

#　启动
start() {
	cd ~/dst/bin
	if [[ ${dst_live[$1]} -eq 0 ]]; then
		screen -S "DST_${cluster_name}_${dst_name[$1]}" -dm sh ${dst_sh[$1]}.sh ${cluster_name} && if [[ $(echo $?) -eq 0 ]]; then
			[ -f ${dst_dir[$1]}/chat.txt.tmp ] && mv ${dst_dir[$1]}/chat.txt.tmp ${dst_dir[$1]}/server_chat_log.txt
			echo -e "\e[36m # ${dst_zh[$1]}启动成功~ \e[0m"
		fi
	else
		echo -e "\e[32m ${dst_zh[$1]}已经在运行中~ \e[0m"
	fi
}

# 停止
stop() {
	if [[ ${dst_live[$1]} -gt 0 ]]; then
		screen -S DST_${cluster_name}_${dst_name[$1]} -p 0 -X stuff "c_shutdown()$(printf \\r)"
		dots=""
		count=0
		while [ $(screen -ls | grep -c DST_${cluster_name}_${dst_name[$1]}) -gt 0 ]; do
			echo -en "\e[32m ${dst_zh[$1]}正在关闭中$dots \e[0m \r"
			sleep 0.5
			count=$((count + 1))
			dots=$(printf "%${count}s" | tr ' ' '.')
			if [ $count -eq 3 ]; then
				count=0
			fi
		done
		echo -ne "\r\e[K"
		echo -e "\e[32m # ${dst_zh[$1]}已停止 √ \e[0m"
		cp ${dst_dir[$1]}/server_chat_log.txt ${dst_dir[$1]}/chat.txt.tmp
	else
		echo -e "\e[32m ${dst_zh[$1]}状态: 关闭 \e[0m"
	fi
}
# 重启
restart() {
	stop $1
	update_status
	start $1
}

# 重置
reset() {
	now=$(date '+%Y-%m-%d')
	bak=${servers}/${now}.reset.bak
	if [ ! -d $bak ]; then
		cp -r $cluster $bak
		echo -e "\e[32m 存档文件已备份于:$bak \e[0m"
	fi

	del $1
	update_status
	start $1
}

#删除当前存档
del() {
	stop $1
	dir=${dst_dir[$1]}

	if test -d ${dir}/save; then
		rm -r ${dir}/{save,backup,*.txt,*.tmp}
		echo -e "\e[32m ##: ${dst_zh[$1]}存档文件删除完毕~ \e[0m"
	fi
}

# 更新游戏版本
updst() {
	type dst-v >/dev/null 2>&1 && remote_v=$(dst-v -v) || remote_v=$($script_dir/dst-v.sh -v)

	if [[ $remote_v -eq $local_v ]]; then
		echo -e "\e[32m!! 饥荒游戏服务器已是最新版本 !! \e[36m[v:$local_v] \e[0m"
		return
	fi

	stop 0
	stop 1
	dir=${dst_dir[0]}
	cp $dir/server_chat_log.txt $dir/chat.txt.tmp

	modlink="$cluster/mods_setup.lua"
	modlua="$dst_install/mods/dedicated_server_mods_setup.lua"

	[ -f $modlink ] || ln $modlua $modlink

	steamcmd +force_install_dir $dst_install +login anonymous +app_update 343050 validate +quit
	if [[ $(echo $?) -eq 0 ]]; then
		echo -e "\e[36m ⭐饥荒游戏版本更新成功 version:[$(cat $dst_install/version.txt)] ⭐ \e[0m"
	fi

	ln -f $modlink $modlua

	update_status
	start 0
	start 1
}

#保存
save() {
	screen -S "$Master_Process" -p 0 -X stuff "c_save()$(printf \\r)"
	echo -e "\e[32m已保存√\e[0m"
}

#回档
rollback() {
	if [ $Master_live -eq 0 ]; then
		echo "---------服务器关闭中----------"
		return 1
	fi
	if [ ! $1 ]; then
		echo "缺少回档天数"
		return 1
	fi
	if [[ $Master_live > 0 ]]; then
		screen -S "$Master_Process" -p 0 -X stuff "c_rollback($rollbackday)$(printf \\r)"
	fi
	if [[ $Caves_live > 0 ]]; then
		screen -S "DST_${cluster_name}_Caves" -p 0 -X stuff "c_rollback($rollbackday)$(printf \\r)"
	fi
	echo -e "\e[32m 已回档$rollbackday 天!\e[0m"
}

#重新生成世界
regenerate() {
	if [ $Master_live -eq 0 ]; then
		echo "---------服务器关闭中----------"
		return 1
	fi
	now=$(date '+%Y-%m-%d')
	cp -r $cluster ${servers}/${now}.regen.bak
	screen -S $Master_Process -p 0 -X stuff "c_regenerateworld()$(printf \\r)"
	# screen -S DST_${dst_name[$1]} -p 0 -X stuff "c_regenerateworld()$(printf \\r)"
}

#公告
announce() {
	if [ $Master_live -eq 0 ]; then
		echo "---------服务器关闭中----------"
		return 1
	fi
	if [ ! $1 ]; then
		echo "缺少公告内容"
		return 1
	fi
	screen -S $Master_Process -p 0 -X stuff "c_announce(\"$1\")$(printf \\r)"
	echo -e "\e[92m信息已发送√ \e[0m"
}

getworldstate() {
	presentseason=""
	presentday=""
	presentcycles=""
	presentphase=""
	presentmoonphase=""
	presentrain=""
	presentsnow=""
	presenttemperature=""

	if [[ $Master_live > 0 ]]; then
		datatime=$(date +%s%3N)
		screen -S $Master_Process -p 0 -X stuff "print(\"\" .. TheWorld.net.components.seasons:GetDebugString() .. \" $datatime print\")$(printf \\r)"
		screen -S $Master_Process -p 0 -X stuff "print(\"\" .. TheWorld.components.worldstate.data.phase .. \" $datatime phase\")$(printf \\r)"
		screen -S $Master_Process -p 0 -X stuff "print(\"\" .. TheWorld.components.worldstate.data.moonphase .. \" $datatime moonphase\")$(printf \\r)"
		screen -S $Master_Process -p 0 -X stuff "print(TheWorld.components.worldstate.data.temperature .. \" $datatime temperature\")$(printf \\r)"
		screen -S $Master_Process -p 0 -X stuff "print(TheWorld.components.worldstate.data.cycles .. \" $datatime cycles\")$(printf \\r)"
		screen -S $Master_Process -p 0 -X stuff "print(\"$datatime:rain:\",TheWorld.components.worldstate.data.israining)$(printf \\r)"
		screen -S $Master_Process -p 0 -X stuff "print(\"$datatime:snow:\",TheWorld.components.worldstate.data.issnowing)$(printf \\r)"

		# sleep 1

		master_log=$master/server_log.txt
		presentseason=$(grep $master_log -e "$datatime print" | cut -d ' ' -f2 | tail -n +2)
		presentday=$(grep $master_log -e "$datatime print" | cut -d ' ' -f3 | tail -n +2)
		presentphase=$(grep $master_log -e "$datatime phase" | cut -d ' ' -f2 | tail -n +2)
		presentmoonphase=$(grep $master_log -e "$datatime moonphase" | cut -d ' ' -f2 | tail -n +2)
		presenttemperature=$(grep $master_log -e "$datatime temperature" | cut -d ' ' -f2 | tail -n +2)
		presentrain=$(grep $master_log -e "$datatime:rain" | cut -d ':' -f6 | tail -n +2)
		presentsnow=$(grep $master_log -e "$datatime:snow" | cut -d ':' -f6 | tail -n +2 | cut -d ' ' -f2)
		presentcycles=$(grep $master_log -e "$datatime cycles" | cut -d ' ' -f2 | tail -n +2)

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

		if [[ $(echo "$presentrain" | grep -c "true") > 0 ]]; then
			presentrain="下雨"
		fi
		if [[ $(echo "$presentrain" | grep -c "false") > 0 ]]; then
			presentrain="无雨"
		fi

		if [[ $(echo "$presentsnow" | grep -c "true") > 0 ]]; then
			presentsnow="下雪"
		fi
		if [[ $(echo "$presentsnow" | grep -c "false") > 0 ]]; then
			presentsnow="无雪"
		fi
	fi

}
getworldname() {
	maxplayer=$(grep "$cluster/cluster.ini" -e "max_players =" | cut -d ' ' -f3)
	world_name=$(grep "$cluster/cluster.ini" -e "cluster_name =" | cut -d ' ' -f3-20)
	passkey=$(grep "$cluster/cluster.ini" -e "cluster_password =" | cut -d ' ' -f3)
	gamemode=$(grep "$cluster/cluster.ini" -e "game_mode =" | cut -d ' ' -f3)
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
getplayernumber() {
	# number=0
	if [[ $Master_live > 0 ]]; then
		allplayersnumber=$(date +%s%3N)
		screen -S $Master_Process -p 0 -X stuff "print(\"AllPlayersNumber \" .. (table.getn(TheNet:GetClientTable())-1) .. \" $allplayersnumber\")$(printf \\r)"
		sleep 1
		number=$(grep $master_log -e "$allplayersnumber" | cut -f3 -d ' ' | tail -n +2)
	fi
}
getplayerlist() {
	if [ $Master_live -gt 0 ]; then
		allplayerslist=$(date +%s%3N)
		screen -S $Master_Process -p 0 -X stuff "for i, v in ipairs(TheNet:GetClientTable()) do  print(string.format(\"playerlist %s %d. ID:[%s] 玩家:\\\\\e[36m[%s]\\\\\e[0m 角色:%s\", $allplayerslist, i-1, v.userid, v.name, v.prefab )) end$(printf \\r)"
		sleep 1
		playerlist=$(grep $master_log -e "playerlist $allplayerslist" | cut -d ' ' -f 4-15 | tail -n +2)
		# if [ ! $Master_live = "" ]; then
		# 	echo $playerlist >$cluster/playerlist.txt
		# fi
	fi
}

serverinfo() {
	if [ $Master_live -eq 0 ]; then
		echo -e "---------服务器关闭中----------"
		return 1
	fi
	echo -en "\e[35m请稍等,正在获取世界和玩家信息.......\e[0m \r"

	getworldname
	getworldstate
	getplayernumber
	getplayerlist

	echo -e "\e[92m------------------世界信息--------------------\e[0m"
	echo -e "\e[33m房名:【$world_name】 密码: 【$passkey】 人数: \e[36m【$number/$maxplayer】\e[0m\e[33m【$gamemode】\e[0m"
	echo -e "\e[33m天数:【$presentcycles】天 【$presentseason】的第【$presentday】天\e[0m"
	echo -e "\e[33m现在:【$presentphase】【$presentmoonphase】【$presentrain】【$presentsnow】【$presenttemperature°C】\e[0m"

	if [[ ! "$playerlist" = "" ]]; then
		echo -e "\e[92m⭐服务器玩家列表⭐\e[0m"
		echo -e "$playerlist"
	fi
	# if [[ master_live > 0 ]]; then
	# 	getmonster
	# 	echo -e "\e[33m猪人火炬:【$pigtorch】个  海象巢:【$walrus_camp】个  触手怪:【$tentacle】个  蜘蛛巢:【$spiderden】个\e[0m"
	# 	echo -e "\e[33m高脚鸟巢:【$tallbirdnest】个  齿轮怪:【$chilun】个  猎犬丘:【$houndmound】个  芦苇:【$reeds】株  墓地:【$mudi】个\e[0m"
	# fi

	echo -e "\e[92m----------------------------------------------\e[0m"
}

checkserver() {
	screen -ls
	if [[ $Master_live > 0 || $Caves_live > 0 ]]; then
		echo -e "\e[36m即将进入世界控制台..... 按住\e[32m Ctrl + A + D \e[0m\e[36m即可脱离\e[0m"
		sleep 1.5
		if [[ $Master_live > 0 ]]; then
			screen -r $Master_Process
		else
			screen -r DST_${cluster_name}_Caves
		fi
	else
		echo -e "\e[31m !!!游戏服务器尚未启动!!! \e[0m"
		sleep 2
		return 1
	fi
}

update_status() {
	Master_Process=DST_${cluster_name}_Master
	Master_live=$(screen -ls | grep -c DST_${cluster_name}_Master)
	Caves_live=$(screen -ls | grep -c DST_${cluster_name}_Caves)
	dst_live=($Master_live $Caves_live)
}

exe() {
	local code=0
	update_status

	if [ $# -eq 0 ]; then
		read -p "输入执行选项, 回车确认操作: " choose
	else
		choose=$1
	fi

	case $choose in
	0)
		status 0
		status 1
		;;
	00)
		status 0
		;;
	01)
		status 1
		;;

	1)
		start 0
		start 1
		;;
	10)
		start 0
		;;
	11)
		start 1
		;;

	2)
		stop 0
		stop 1
		;;
	20)
		stop 0
		;;
	21)
		stop 1
		;;

	3)
		restart 0
		restart 1
		;;
	30)
		restart 0
		;;
	31)
		restart 1
		;;

	4)
		del 0
		del 1
		;;
	40)
		del 0
		;;
	41)
		del 1
		;;

	5)
		reset 0
		reset 1
		;;
	50)
		reset 0
		;;
	51)
		reset 1
		;;

	up)
		updst
		;;
	rb)
		read -p "请输入你要回档的天数(1~5): " rollbackday
		rollback $rollbackday
		;;
	rg)
		regenerate
		;;
	an)
		read -p "请输入公告内容: " announcement
		announce $announcement
		;;
	ls)
		serverinfo
		;;
	x)
		checkserver
		;;
	q)
		echo -e "\e[1;32mBye ~ \e[0m"
		exit 0
		;;
	*)
		echo -e "\e[1;31m请输入正确的指令!! \e[0m"
		echo 1 >/dev/null
		;;
	esac

	code=$?
	if [ $# -gt 0 ]; then
		return $code
	fi

	sleep 0.5
	exe
}

# main
type dst-v >/dev/null 2>&1 && (dst-v -s &) || $script_dir/dst-v.sh -s &
# main $@

if [ $# -gt 0 ]; then
	exe $@
	exit $?
fi
echo -e "\e[22;42;30m ##====[ Don't Starve Togther 管理控制台 <\e[1;37mv$local_v\e[0m\e[22;42;30m> ]====## \e[0m"
echo -e "[\e[1;32m 1 \e[0m] 启动游戏服务器            [\e[1;32m 2 \e[0m] 停止游戏进程"
echo -e "[\e[1;32m 3 \e[0m] 重启游戏进程(可更新mod)   [\e[1;32m 4 \e[0m] 删除服务器游戏存档"
echo -e "[\e[1;32m 5 \e[0m] 重置饥荒服务器,将删除游戏存档"

echo -e "[\e[1;36m up \e[0m] 饥荒游戏服务器版本更新   [\e[1;36m rb \e[0m] 游戏服务器世界回档"
echo -e "[\e[1;36m rg \e[0m] 游戏世界地图重新生成     [\e[1;36m an \e[0m] 公告发送喊话通知"
echo -e "[\e[1;36m ls \e[0m] 查看服务器内玩家列表"
echo -e "[\e[1;33m x \e[0m] 切换到游戏进程控制台      [\e[1;31m q \e[0m] 退出"
echo -e "PS: 数字选项加 0或1可以单独操作地上或洞穴, 如\e[1;32m 10 \e[0m即启动地上"
echo ""
echo -e "\e[96m----饥荒服务器运行状态-----\e[0m"
exe 0
echo -e "\e[96m-------------------------\e[0m"

if [[ $Master_live > 0 ]]; then
	read -p "服务器运行中,是否获取世界和玩家信息? [y/n] " -n 1
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		serverinfo
	fi
fi

exe
