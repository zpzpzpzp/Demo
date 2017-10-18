#!/bin/bash
set -e
ssh hbao@10.209.21.215 '
tomcat_path = /Users/hbao/Downloads/apache-tomcat-7.0.82
TomcatID = $(ps -ef |grep tomcat |grep -w $tomcat_path|grep -v 'grep'|awk '{print $2}')
                
StopTomcat = /Users/hbao/Downloads/apache-tomcat-7.0.82/bin/shutdown.sh
                
if[($TomcatID)]; then
   echo "当前Tomcat进程ID为：$TomcatID, 需要关闭..."
   $StopTomcat
else
   echo "当前环境没有Tomcat启动"
fi
                   
rm -rf /Users/hbao/Downloads/apache-tomcat-7.0.82/webapps/webdemo
rm -f /Users/hbao/Downloads/apache-tomcat-7.0.82/webapps/webdemo.war
'
                
cd /var/jenkins_home/workspace/TestForPipeline/webdemo/build/libs
                
scp webdemo.war hbao@10.209.21.215:/Users/hbao/Downloads/apache-tomcat-7.0.82/webapps
ssh hbao@10.209.21.215 '
cd /Users/hbao/Downloads/apache-tomcat-7.0.82/bin
./startup.sh
'

