//  Pipeline //
Pipeline {
    agent any
    
    stages {

        stage('Build') {
            steps{
                script{
                    try{
                     sh 'cd webdemo && ./gradlew build -x test'
                  }
                  catch(exc){
                       echo "something failed"
                  }
                }
            }
        }

        stage('Test') {
            steps{
                echo 'Testing..'
                sh 'cd webdemo && ./gradlew test'
            }
        }

        stage('SonarQube analysis') {
            steps{
                echo "starting codeAnalyze with SonarQube......"
                script{
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
                } 
            }
        }
        
        stage('Deploy') {
            steps{
                 echo 'Deploying..' 
                sh """
                    set -e
                    ssh hbao@10.209.22.46 'bash -s' < checktomcatstatus.sh
                    cd /var/jenkins_home/workspace/TestForPipeline/webdemo/build/libs
                    scp webdemo.war hbao@10.209.22.46:/Users/hbao/Downloads/apache-tomcat-7.0.82/webapps
                    ssh hbao@10.209.22.46 '
                        cd /Users/hbao/Downloads/apache-tomcat-7.0.82/bin
                        ./startup.sh
                    '
                """ 
            }
        }
        
    }
}



