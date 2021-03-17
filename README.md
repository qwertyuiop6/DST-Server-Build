## 搭建饥荒游戏 server

### SteamCMD Usage

[SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD)

### Klei guides

[Klei guide](http://dont-starve-game.wikia.com/wiki/Guides/Don%E2%80%99t_Starve_Together_Dedicated_Servers)

[Klei guide2](http://steamcommunity.com/sharedfiles/filedetails/?id=590565473)

### My article

> DST-Server 饥荒服务搭建详细小白教程:
> [Click me](https://wtfk.world/2017/11/02/my-first-article/)

## DST Server 快速搭建

#### 1. 获取本项目代码

- 使用 git 克隆

```shell
git clone git@github.com:qwertyuiop6/DST-Server-Build.git
```

- 或者 使用 http 下载

```shell
sudo apt install unzip -y&&wget https://github.com/qwertyuiop6/DST-Server-Build/archive/master.zip

unzip master.zip&&mv DST-Server-Build-master DST-Server-Build&&rm master.zip
```

#### 2. 赋权并运行

```shell
cd DST-Server-Build&&sudo chmod +x dst-go.sh&&./dst-go.sh
```

## DST Server 日常管理命令

#### `dst` 命令

按照提示输入数字指令操作游戏服务器

- 0 : 查看游戏服务器状态
- 1 : 启动地上+洞穴游戏进程
- 2 : 停止游戏进程
- 3 : 重启游戏进程,可以用来更新 mod
- 4 : 更新饥荒游戏服务器版本
- 5 : 删除服务器保存的游戏存档,日志等
- 6 : 重置饥荒游戏服务器,将删除游戏存档记录

> 可在选项后增加一位数字 0 或 1,单独操作地上或洞穴游戏进程,如　 10: 启动地上

### Other

饥荒游戏 Server[微信测试/公众号管理](https://github.com/qwertyuiop6/wx-dst-admin)
