// Declarative //
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'cd webdemo && ./gradlew build'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh 'cd webdemo && ./gradlew build || true'
                junit '**/target/*.xml'
            }
        }
        
        stage('SonarQube') {
           steps {
               echo "starting codeAnalyze with SonarQube......"
               //sonar:sonar.QualityGate should pass
               withSonarQubeEnv('SonarQube') {
                 //固定使用项目根目录${basedir}下的pom.xml进行代码检查
                 sh "mvn -f pom.xml clean compile sonar:sonar"
               }
               script {
               timeout(10) { 
                   //利用sonar webhook功能通知pipeline代码检测结果，未通过质量阈，pipeline将会fail
                   def qg = waitForQualityGate() 
                       if (qg.status != 'OK') {
                           error "未通过Sonarqube的代码质量阈检查，请及时修改！failure: ${qg.status}"
                       }
                   }
               }
           }
       }
        
       // stage('Deploy') {
         //   when {
           //     expression {
                    /*如果测试失败，状态为UNSTABLE*/
             //       currentBuild.result == null || currentBuild.result == 'SUCCESS'
               // }
            //}
            //steps {
              //  echo 'Deploying..'
                //sh 'make publish'
            //}
        //}
        
    }
}

