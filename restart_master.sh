#!/bin/bash
ps -ef|grep dontstarve|awk '{print $2}'|xargs kill -9
cd .klei/DoNotStarveTogether/MyDediServer/Master/ 
rm -r save&&rm *.txt
cd ~/dst/bin/
screen sh overworld.sh