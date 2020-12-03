node("docker && awsaccess") {
  cleanWs()
  checkout scm

  stage("Build Image") {
    withDockerRegistry(registry: [credentialsId: "docker_hub"]) {
      sh "docker-compose build"
    }
  }

  stage("Lint and Unit Test") {
    sh "docker-compose run gem-tests"
  }

  stage("Cleanup Docker") {
    sh "docker-compose down"
  }
}
