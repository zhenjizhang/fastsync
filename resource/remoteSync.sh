#!/bin/sh

expect -c "
set timeout 60
spawn ssh gwpek

expect \"PRODUCTION\" {send \" ssh-add -L\r \"}

expect \"PRODUCTION\" {send \" ssh [服务器地址]\r \"}

expect \"PRODUCTION\" {send \" cd [服务器代码仓库地址]];git co master; git b -D [暂存代码的分支名称]; git co -b [暂存代码的分支名称] ; git pull --no-edit origin [暂存代码的分支名称];exit\r \"}

expect \"PRODUCTION\"  {send \" exit\r \"}
expect eof
exit
"
