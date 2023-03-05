#!/bin/bash

#安装必要的软件包
sudo add-apt-repository multiverse
sudo dpkg --add-architecture i386
sudo apt update
sudo apt-get install lib32gcc-s1 lib32gcc1 lib32stdc++6 libcurl3-gnutls:i386 libcurl4-gnutls-dev:i386 screen python3 python3-pip -y

pip3 install requests lxml

#安装steamcmd
sudo apt install steamcmd 

#创建steamcmd文件夹
#mkdir ~/steamcmd
#cd ~/steamcmd

#下载steamcmd
#wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
#tar -xvzf steamcmd_linux.tar.gz

#登录steamcmd+安装饥荒服务端到~/dst
steamcmd +force_install_dir ../../dst +login anonymous  +app_update 343050 validate +quit

#修正一个经常出现的包缺失问题
# cp ~/steamcmd/linux32/libstdc++.so.6 ~/dst/bin/lib32/

#进入饥荒启动可执行文件入口
cd ~/dst/bin

#分别为地上,洞穴建立快速启动的shell脚本
echo ./dontstarve_dedicated_server_nullrenderer -console -cluster MyDediServer -shard Master > overworld.sh
echo ./dontstarve_dedicated_server_nullrenderer -console -cluster MyDediServer -shard Caves > cave.sh

chmod +x overworld.sh cave.sh

#提示语
#if [[ `echo $?` -eq 0 ]]; then
#	echo -e "\033[42;30m ### 游戏服务器初始化完成... \033[0m"
#else
#	echo -e "\033[31m 执行出现了错误，可能因为网络不好，请尝试重新执行一次 \033[0m"
#fi

script_dir=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
cd $script_dir

#赋予可执行权限
sudo chmod +x dst-admin.sh dst-v.sh
#添加命令链接到系统路径
sudo ln dst-admin.sh /usr/local/bin/dst
sudo ln dst-v.sh /usr/local/bin/dst-v

#创建一个饥荒server存档目录
DST="$HOME/.klei/DoNotStarveTogether/MyDediServer"
mkdir -p $DST

#复制服饥荒务器配置文件
cp {cluster_token.txt,cluster.ini,adminlist.txt,blocklist.txt,whitelist.txt,customcommands.lua} $DST
cp modoverrides.lua $DST/mods_enable.lua
#世界生成参数的配置
cp -r {Master,Caves} $DST
#mod下载的配置
cp -r mods ~/dst

#链接 mod下载配置,启用配置,自定义命令 文件
ln -f $DST/mods_enable.lua $DST/Master/modoverrides.lua
ln -f $DST/mods_enable.lua $DST/Caves/modoverrides.lua
ln ~/dst/mods/dedicated_server_mods_setup.lua $DST/mods_setup.lua
ln $DST/customcommands.lua $DST/Master/ $DST/Caves/

#配置个人token
echo -en "\033[32m请输入您的私人饥荒token,回车确认:\033[0m"
read token
echo $token > $DST/cluster_token.txt

echo -e "\033[32m### 请记住-->\033[34m dst \033[0m\033[32m<--这个命令,使用它可以便捷管理你的游戏服务器! \033[0m"
echo -e "接下来你需要做的是:\n\033[32m1.修改游戏的各种配置文件(服务器信息,mod下载和启用和地图生成)\033[0m\n\033[32m2.使用\033[34m dst \033[0m\033[32m命令来操作游戏服务器\033[0m"