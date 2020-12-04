node("docker && awsaccess") {
  cleanWs()
  checkout scm

  stage("Build/Run/Cleanup Image") {
    withDockerRegistry(registry: [credentialsId: "docker_hub"]) {
      sh "docker-compose run --rm gem-tests"
    }
  }
}
