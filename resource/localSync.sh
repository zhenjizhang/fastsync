#!/usr/bin/env bash
# author: zhangzhenji 2023-02-19
# 用于把代码同步到线上机器

LOCAL_BRANCH=`git status | head -1 | awk -F' ' '{print $3}'`
GIT_BRANCH="your-tmp-branch"
COMMIT_ID=`git log | head -1 | awk -F' ' '{print $2}'`
PARAM1=$1
PARAMS=$@

echo "LOCAL_BRANCH"=${LOCAL_BRANCH}
echo "GIT_BRANCH="${GIT_BRANCH}
echo "COMMIT_ID="${COMMIT_ID}

if [ $PARAM1 == '.' ]; then
	echo "PARAM1="${PARAM1}
	PARAMS=`git st | awk -f .git/gitawk | tr '\n' ' '`;
fi

echo "PARAMS="${PARAMS}

PARAM_ARR=(${PARAMS// / })

TMP_PATH=~/Desktop/zhihu/tmp
mkdir ~/Desktop/zhihu/tmp

git branch -D ${GIT_BRANCH}
git checkout -b ${GIT_BRANCH}

for arg in ${PARAM_ARR[@]}
do
	arg_path=""
	result=$(echo $arg | grep "\/")
	if [[ "${result}" != ""  ]] 
	then
		arg_path="${arg%/*}"
	else	
		arg_path=""
	fi
	echo "mkdir -p ${TMP_PATH}/${arg_path}"
	mkdir -p ${TMP_PATH}/${arg_path}
	echo "cp $arg ${TMP_PATH}/${arg_path}/"
	cp $arg ${TMP_PATH}/${arg_path}
	echo "git add $arg"
	git add $arg
	echo "$arg done"
done

TIME_FMT=`date +"%Y%m%d-%H%M%S"`
echo "git commit -m'${TIME_FMT}-update'"
git commit -m"${TIME_FMT}-update"

echo "git push -f origin ${GIT_BRANCH}"
git push -f origin ${GIT_BRANCH}

echo "git checkout ${LOCAL_BRANCH}"
git checkout ${LOCAL_BRANCH}

echo "git branch -D ${GIT_BRANCH}"
git branch -D ${GIT_BRANCH}

for arg in ${PARAM_ARR[@]}
do
	arg_path=""
	result=$(echo $arg | grep "\/")
	if [[ "${result}" != ""  ]] 
	then
		arg_path="${arg%/*}"
	else	
		arg_path="."
	fi
	echo "mv ${TMP_PATH}/${arg} ${arg%/*}/"
	mkdir ${arg%/*}/
	mv ${TMP_PATH}/${arg} ${arg%/*}/
	echo "mv $arg done"
done

echo "rm -rf ${TMP_PATH}/"
rm -rf ${TMP_PATH}/

sh .git/remoteSync.sh
