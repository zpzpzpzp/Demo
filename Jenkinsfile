// script Pipeline //
node {
    
    stage ("checkout"){
        git url: 'https://github.com/Mokaffe/DemoTestForBuild.git'
    }

       stage('Build') {
           try{
               sh 'cd webdemo && ./gradlew build -x test'
           }catch(e){
               notifyStarted("Build Failed in Jenkins!")
               throw e
           }       
        }

        stage('Test') {
            try{
                sh 'cd webdemo && ./gradlew test'
            }catch(e){
                notifyStarted("Test Failed in Jenkins!")
                throw e
            }
        }

        stage('SonarQube analysis') {
            try{
                def sonarqubeScannerHome = tool name:'SonarScannerTest'
                    withSonarQubeEnv('SonarSeverTest') {
                        sh "${sonarqubeScannerHome}/bin/sonar-scanner"
                    }
                
                timeout(4) { 
                   //利用sonar webhook功能通知pipeline代码检测结果，未通过质量阈，pipeline将会fail
                   def qg = waitForQualityGate() 
                       if (qg.status != 'OK') {
                           error "It doesn't pass Sonarqube scanner gate setting，Please fix it！failure: ${qg.status}"
                       }
                    }
            }catch(e){
                notifyStarted("SonarQube Failed in Jenkins!")
                throw e
            }
        }
        
        stage('Deploy') {
            try{
                sh """
                    set -e
                    ssh hbao@10.209.22.168 'bash -s' < checktomcatstatus.sh
                    cd /var/jenkins_home/workspace/TestForPipeline/webdemo/build/libs
                    scp webdemo.war hbao@10.209.22.168:/Users/hbao/Downloads/apache-tomcat-7.0.82/webapps
                    ssh hbao@10.209.22.168 '
                        cd /Users/hbao/Downloads/apache-tomcat-7.0.82/bin
                        ./startup.sh
                    '
                """
            }catch(e){
                notifyStarted("SonarQube Failed in Jenkins!")
                throw e
            }
        }
        
}



