#!/bin/sh 

MODULE_MAIN=$(grep "__main__" *.py | awk -F ':' '{ print $1 }' | awk -F '.' '{ print $1 }')

if [ "MODULE_MAIN" = "" ]; then
	echo "错误: 当前目录python文件缺少入口 __main__ "
	exit 1
fi

echo "警告: 缺少uwsgi.ini文件\n"
echo "
[uwsgi]
module = $MODULE_MAIN
callable = app" >./uwsgi.ini 
exit 0

