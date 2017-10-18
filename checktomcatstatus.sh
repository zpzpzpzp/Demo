#!/bin/bash

tomcat_path=/Users/hbao/Downloads/apache-tomcat-7.0.82
TomcatID=$(ps -ef |grep tomcat |grep -w $tomcat_path|grep -v 'grep'|awk '{print $2}')

StopTomcat=/Users/hbao/Downloads/apache-tomcat-7.0.82/bin/shutdown.sh

if [ $TomcatID ]; then
   echo "当前Tomcat进程ID为：$TomcatID, 需要关闭..."
   $StopTomcat
else
   echo "当前环境没有Tomcat启动"
fi

rm -rf /Users/hbao/Downloads/apache-tomcat-7.0.82/webapps/webdemo
rm -f /Users/hbao/Downloads/apache-tomcat-7.0.82/webapps/webdemo.war