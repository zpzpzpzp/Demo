#!/bin/bash

tomcat_path = /Users/hbao/Downloads/apache-tomcat-7.0.82
TomcatID = $(ps -ef |grep tomcat |grep -w $tomcat_path|grep -v 'grep'|awk '{print $2}')

if[-n $TomcatID]；
   then
      echo "$TomcatID tomcat is starting, need to stop"
      cd /Users/hbao/Downloads/apache-tomcat-7.0.82/bin
      ./shutdown.sh
   else
      echo "tomcat not start ..."

rm -rf /Users/hbao/Downloads/apache-tomcat-7.0.82/webapps/webdemo
rm -f /Users/hbao/Downloads/apache-tomcat-7.0.82/webapps/webdemo.war
exit

cd /var/jenkins_home/workspace/TestForPipeline/webdemo/build/libs
scp webdemo.war hbao@10.209.21.215:/Users/hbao/Downloads/apache-tomcat-7.0.82/webapps
ssh -tt hbao@10.209.21.215
cd /Users/hbao/Downloads/apache-tomcat-7.0.82/bin
./startup.sh
exit

