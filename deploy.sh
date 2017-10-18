#!/bin/bash


cd /Users/hbao/Downloads/apache-tomcat-7.0.82/bin
./shutdown.sh
rm -rf /Users/hbao/Downloads/apache-tomcat-7.0.82/webapps
rm -f /Users/hbao/Downloads/apache-tomcat-7.0.82/webapps/webdemo.war
cd /var/jenkins_home/workspace/TestForPipeline/webdemo/build/libs
scp webdemo.war hbao@10.209.21.215:/Users/hbao/Downloads/apache-tomcat-7.0.82/
cd /Users/hbao/Downloads/apache-tomcat-7.0.82/bin
./startup.sh