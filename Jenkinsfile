pipeline {

  agent any 

  environment{
    REPO_EXISTS = fileExists 'data/web/drupal'
  }

//  environment {
//    IMAGE = 'registry.gitlab.com/XXXXX/bible-server'
//    DOCKER_REGISTRY_CREDENTIALS = credentials('DOCKER_REGISTRY_CREDENTIALS')
//  }

  options {
    timeout(10)
  }

  stages {
    stage('Init') {
      steps {
        sh 'mkdir -p data/web'
      }
    }

    stage('clone') {
      steps {
        catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
          sh 'git clone https://github.com/janetuk/myjisc.git data/web/drupal'
        }
      }
    }

    stage('checkout') {
      steps {
        sh '(cd data/web/drupal && git checkout develop)'
        sh 'source .project_name && make && echo export PROJECT_NAME=$PROJECT_NAME >  .pname '
      }
    }
    
    stage('composer') {
      steps {
        sh "source .pname && echo pn $PROJECT_NAME"
        sh "source .pname && export CMD='composer install' &&  sh -c 'make fpmi '"
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
//      mail to: "XXXXX@gmail.com", subject:"SUCCESS: ${currentBuild.fullDisplayName}", body: "Yay, we passed."
      echo  'succedeed'
    }
    failure {
      echo 'failed'
//      mail to: "XXXXX@gmail.com", subject:"FAILURE: ${currentBuild.fullDisplayName}", body: "Boo, we failed."
    }
  }
}

