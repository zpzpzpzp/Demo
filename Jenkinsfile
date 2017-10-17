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
                /* `make check` returns non-zero on test failures,
                 *  using `true` to allow the Pipeline to continue nonetheless
                 */
                sh 'cd webdemo && ./gradlew build || true' ①
                junit '**/target/*.xml' ②
            }
        }
        stage('Deploy') {
            when {
                expression {
                    /*如果测试失败，状态为UNSTABLE*/
                    currentBuild.result == null || currentBuild.result == 'SUCCESS' ①
                }
            }
            steps {
                echo 'Deploying..'
                sh 'make publish'
            }
        }
    }
}

