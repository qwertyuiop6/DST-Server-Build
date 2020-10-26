#!/bin/bash

#安装必要的软件包
sudo apt-get update
sudo apt-get install lib32gcc1 libcurl4-gnutls-dev:i386 screen python3 python3-pip -y

pip3 install requests lxml

#创建steamcmd文件夹
mkdir ~/steamcmd
cd ~/steamcmd

#下载steamcmd
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xvzf steamcmd_linux.tar.gz

#登录steamcmd+安装饥荒服务端到~/dst
./steamcmd.sh +login anonymous +force_install_dir ~/dst +app_update 343050 validate +quit
#修正一个经常出现的包缺失问题
cp ~/steamcmd/linux32/libstdc++.so.6 ~/dst/bin/lib32/

#进入饥荒启动可执行文件入口
cd ~/dst/bin

#分别为地上,洞穴建立快速启动的shell脚本
echo ./dontstarve_dedicated_server_nullrenderer -console -cluster MyDediServer -shard Master > overworld.sh
echo ./dontstarve_dedicated_server_nullrenderer -console -cluster MyDediServer -shard Caves > cave.sh

#创建饥荒server主配置+数据文件夹
mkdir -p ~/.klei/DoNotStarveTogether/MyDediServer
# cd ~

#提示语
if [[ `echo $?` -eq 0 ]]; then
	echo -e "\033[42;30m ### 游戏服务器初始化完成... \033[0m"
else
	echo -e "\033[31m 执行出现了错误，可能因为网络不好，请尝试重新执行一次 \033[0m"	
fi


cd ~/DST-Server-Build

#赋予可执行权限
sudo chmod +x dst-admin.sh dst-v.sh
#添加命令链接到系统路径
sudo ln dst-admin.sh /usr/local/bin/dst
sudo ln dst-v.sh /usr/local/bin/dst-v

#复制服饥荒务器配置文件
cp {cluster_token.txt,cluster.ini} ~/.klei/DoNotStarveTogether/MyDediServer
cp -r {Master,Caves} ~/.klei/DoNotStarveTogether/MyDediServer
cp -r mods ~/dst

#path

#link
ln ~/.klei/DoNotStarveTogether/MyDediServer/Master/modoverrides.lua ~/.klei/DoNotStarveTogether/MyDediServer/Caves/modoverrides.lua -b
ln -s ~/.klei/DoNotStarveTogether/MyDediServer/Master/modoverrides.lua ./mods_enable.lua
ln -s ~/dst/mods/dedicated_server_mods_setup.lua ./mods_setup.lua


echo -en "\033[32m请输入您的私人饥荒token,回车确认:\033[0m"
read token
echo $token > ~/.klei/DoNotStarveTogether/MyDediServer/cluster_token.txt

echo -e "\033[32m### 请记住-->\033[34m dst \033[0m\033[32m<--这个命令,使用它可以便捷管理你的游戏服务器! \033[0m"
echo -e "接下来你需要做的是:\n\033[32m1.修改游戏的各种配置文件(服务器信息设置,mod下载配置,mod启用配置,地图配置等)\033[0m\n\033[32m2.使用\033[34m dst \033[0m\033[32m命令来操作游戏服务器\033[0m"