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
}

 def notifyStarted(String message) {
     sh 'echo ${message}'
    }
        



