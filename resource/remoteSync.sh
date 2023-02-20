#!/bin/sh

expect -c "
set timeout 60
spawn ssh jumper-host

expect \"PRODUCTION\" {send \" ssh-add -L\r \"}

expect \"PRODUCTION\" {send \" ssh remote-host-addr\r \"}

expect \"PRODUCTION\" {send \" cd remote-git-path;git co master; git b -D your-tmp-branch; git co -b your-tmp-branch ; git pull --no-edit origin your-tmp-branch;exit\r \"}

expect \"PRODUCTION\"  {send \" exit\r \"}
expect eof
exit
"
