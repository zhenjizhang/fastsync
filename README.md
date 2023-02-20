# fastsync
用于存在跳板机情况下，同步本地与服务器代码，适用于含有跳板机的环境

下载 fastsync.sh 后

运行 sh fastsync.sh {your-tmp-branch} {jumper-host} {remote-host} {remote-git-path}

sh fastsync.sh zzj-TestBranch jumper xxx.xxx.com "~\/data\/fastsync"

注意：不支持 rename delete 等后的同步，其他隐藏 bug 暂未发现，欢迎补充

使用此工具可能造成代码丢失，请仔细阅读源码。使用此工具造成的代码丢失，工具提供者概不负责
