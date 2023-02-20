#!/usr/bin/env bash

YOUR_TMP_BRANCH=$1
REMOTE_HOST=$2
REMOTE_GIT_PATH=$3
echo "YOUR_TMP_BRANCH: ${YOUR_TMP_BRANCH}"
echo "REMOTE_HOST: ${REMOTE_HOST}"
echo "REMOTE_GIT_PATH: ${REMOTE_GIT_PATH}"
git clone git@github.com:zhenjizhang/fastsync.git
mv fastsync/resource/* .git/
eval sed -e 's/your-tmp-branch/${YOUR_TMP_BRANCH}/g' .git/localSync.sh
eval sed -e 's/your-tmp-branch/${YOUR_TMP_BRANCH}/g' .git/remoteSync.sh
eval sed -e 's/remote-host-addr/${REMOTE_HOST}/g' .git/remoteSync.sh
eval sed -e 's/remote-git-path/${REMOTE_GIT_PATH}/g' .git/remoteSync.sh

if [ `grep -c "fastsync" ~/.zshrc` -eq '0' ]; then
    echo "alias fastsync='sh .git/localSync.sh'" >> ~/.zshrc
fi
rm -rf fastsync
echo "installation is complete."
