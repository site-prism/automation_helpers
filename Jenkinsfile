node("docker && awsaccess") {
  cleanWs()
  checkout scm

  stage("Build Image") {
    withDockerRegistry(registry: [credentialsId: "docker_hub"]) {
      docker.build("ca_testing")
    }
  }

  stage("Lint and Unit Test") {
    docker.image("ca_testing").inside {
      sh "bundle exec rake"
    }
  }

  stage("Cleanup Docker") {
    sh "docker rmi ca_testing -f || true"
  }
}
