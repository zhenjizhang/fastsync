#!/usr/bin/env bash
#author: zhangzhenji 2023-02-19 

YOUR_TMP_BRANCH=$1
JUMPER_HOST=$2
REMOTE_HOST=$3
REMOTE_GIT_PATH=$4
echo "YOUR_TMP_BRANCH: ${YOUR_TMP_BRANCH}"
echo "JUMPER_HOST: ${JUMPER_HOST}"
echo "REMOTE_HOST: ${REMOTE_HOST}"
echo "REMOTE_GIT_PATH: ${REMOTE_GIT_PATH}"
git clone https://github.com/zhenjizhang/fastsync.git

sed -i '' "s/your-tmp-branch/${YOUR_TMP_BRANCH}/g" fastsync/resource/localSync.sh
sed -i '' "s/your-tmp-branch/${YOUR_TMP_BRANCH}/g" fastsync/resource/remoteSync.sh
sed -i '' "s/jumper-host/${JUMPER_HOST}/g" fastsync/resource/remoteSync.sh
sed -i '' "s/remote-host-addr/${REMOTE_HOST}/g" fastsync/resource/remoteSync.sh
sed -i '' "s/remote-git-path/${REMOTE_GIT_PATH}/g" fastsync/resource/remoteSync.sh
mv fastsync/resource/* .git/

if [ `grep -c "sh .git/localSync.sh" ~/.zshrc` -eq '0' ]; then
    if [`grep -c "fastsync" ~/.zshrc` -eq '0']; then
        echo "alias fastsync='sh .git/localSync.sh'" >> ~/.zshrc
    fi
    if [`grep -c "fs" ~/.zshrc` -eq '0']; then
        echo "alias fs='sh .git/localSync.sh'" >> ~/.zshrc
    fi
fi
rm -rf fastsync
echo "installation is complete."
echo "rm fastsync.sh by yourself."
