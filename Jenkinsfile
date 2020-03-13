pipeline {

  agent any 

//  environment {
//    IMAGE = 'registry.gitlab.com/XXXXX/bible-server'
//    DOCKER_REGISTRY_CREDENTIALS = credentials('DOCKER_REGISTRY_CREDENTIALS')
//  }

  options {
    timeout(10)
  }

  stages {

    stage('Checkout') {
      steps {
        sh 'mkdir -p data/web'
        sh 'git clone https://github.com/janetuk/myjisc.git data/web/drupal'
        sh '(cd data/web/drupal && checkout develop)'
        sh 'make'         
      }
    }

//    stage('Test') {
//      steps {
//        sh 'yarn'
//        sh 'npm test'
//      }
//    }

//    stage('Build') {
//      when {
//        branch '*/master'
//      }
//      steps {
//        sh 'docker login -u ${DOCKER_REGISTRY_CREDENTIALS_USR} -p ${DOCKER_REGISTRY_CREDENTIALS_PSW} registry.gitlab.com'
//        sh 'docker build -t ${IMAGE}:${BRANCH_NAME} .'
//        sh 'docker push ${IMAGE}:${BRANCH_NAME}'
//      }
//    }

//    stage('Deploy') {
//      when {
//        branch '*/master'
//      }
//      steps {
//        echo 'Deploying ..'
//      }
//    }
  }

  post {
    success {
      mail to: "XXXXX@gmail.com", subject:"SUCCESS: ${currentBuild.fullDisplayName}", body: "Yay, we passed."
    }
    failure {
      mail to: "XXXXX@gmail.com", subject:"FAILURE: ${currentBuild.fullDisplayName}", body: "Boo, we failed."
    }
  }
}
