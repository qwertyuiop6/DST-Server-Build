#!/bin/bash

#------------安装必要的软件包---------------
sudo add-apt-repository multiverse
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install libcurl3-gnutls:i386 libcurl4-gnutls-dev:i386 screen jq libxml2-utils -y

dst_dir=/dst
cluster=MyDediServer
dst_install="${HOME}${dst_dir}"

#-----------安装steamcmd和游戏-------------
type steamcmd 2>/dev/null || sudo apt install lib32gcc-s1 lib32stdc++6 steamcmd -y

if steamcmd +app_info_print 343050 +quit | grep 'installdir' >/dev/null 2>&1; then
    cp $dst_install/mods/dedicated_server_mods_setup.lua $script_dir/mods
fi

#登录steamcmd+安装饥荒服务端到~/dst
steamcmd +force_install_dir $dst_install +login anonymous +app_update 343050 validate +quit

if [[ $(echo $?) -eq 0 ]]; then
    echo -e "\033[42;30m ### 游戏安装更新完毕 \033[0m"
else
    echo -e "\033[31m 执行出现了错误，可能因为网络不好，请尝试重新执行一次 \033[0m"
fi

#-----------创建存档和启动脚本---------
create_cluster() {
    if [ -d $1 ]; then
        echo -e "\e[1;31m存档 $1 已存在!! \e[0m"
        exit 1
    fi

    declare new_cluster=true
    mkdir -p $1
    echo -e "\e[32m存档已创建,位于:[\e[36m $1 \e[0m\e[32m ] \e[0m"
    sleep 0.3
}

DST="$HOME/.klei/DoNotStarveTogether/$cluster"
if [ -d $DST ]; then
    read -p "存档${cluster}已经存在,你是要创建新存档吗? 输入[ y: 创建新存档 n: 更新服务器]:" -n 1
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "\e[32m请输入您要创建的存档名称,回车确认:\e[0m" newcluster
        if [ ! -z "$newcluster" ]; then
            DST="$HOME/.klei/DoNotStarveTogether/$newcluster"
            create_cluster $DST
        fi
    fi
else
    create_cluster $DST
fi

#为世界建立快速启动的shell脚本
if [ -n $new_cluster ]; then
    cd $dst_install/bin
    # if [ ! -f $dst_install/bin/overworld.sh ]; then
    #分别为地上,洞穴建立快速启动的shell脚本
    echo ./dontstarve_dedicated_server_nullrenderer -console -cluster '$1' -shard Master >overworld.sh
    echo ./dontstarve_dedicated_server_nullrenderer -console -cluster '$1' -shard Caves >cave.sh
    chmod +x overworld.sh cave.sh
    # fi
fi

#---------复制必要文件配置和创建token----------
cd $script_dir

#复制mod下载列表的配置
cp mods/dedicated_server_mods_setup.lua $dst_install/mods

#复制饥荒服务器配置文件到存档
if [ -n $new_cluster ]; then
    cp {cluster.ini,adminlist.txt,blocklist.txt,whitelist.txt} $DST
    #世界,地图生成参数 的配置
    cp -r {Master,Caves} $DST
    #链接mod配置
    ln -f $dst_install/mods/dedicated_server_mods_setup.lua $DST/mods_setup.lua
    #链接启用配置文件
    cp modoverrides.lua $DST/mods_enable.lua
    ln -f $DST/mods_enable.lua $DST/Master/modoverrides.lua
    ln -f $DST/mods_enable.lua $DST/Caves/modoverrides.lua
    #ln $DST/customcommands.lua $DST/Master/customcommands.lua
    #ln $DST/customcommands.lua $DST/Caves/customcommands.lua
fi

#配置个人token
if [ ! -f $DST/cluster_token.txt ]; then
    read -p $'\e[32m请输入您的私人饥荒token,回车确认:\e[0m' token
    echo $token >$DST/cluster_token.txt
fi

#----------dst控制台管理命令-----------
if ! type dst 2>/dev/null || ! type dst-v 2>/dev/null; then
    sudo chmod +x dst-admin.sh dst-v.sh
    sudo ln -f dst-admin.sh /usr/local/bin/dst
    sudo ln -f dst-v.sh /usr/local/bin/dst-v
    echo -e "\033[32m请记住-->\033[35m dst \033[0m\033[32m<--这个命令,使用它可以通过命令行快捷管理你的游戏服务器! \033[0m"
fi

if [ -n $new_cluster ]; then
    echo -e "接下来你需要做的是:\n\033[32m1.修改${DST}里的各种配置文件(服务器信息,mod下载,启用配置和地图生成配置)\033[0m\n\033[32m2.使用\033[34m dst \033[0m\033[32m命令来操作游戏服务器\033[0m"
fi
