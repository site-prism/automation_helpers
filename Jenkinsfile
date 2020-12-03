node("docker && awsaccess") {
  cleanWs()
  checkout scm

  stage("Build Image") {
    withDockerRegistry(registry: [credentialsId: "docker_hub"]) {
//       docker.build("ca_testing")
      sh "docker-compose build"
    }
  }

  stage("DEBUG after build") {
    sh "docker-compose run gem-tests ls -la"
    sh "docker-compose run gem-tests ls -la .."
    sh "docker-compose run gem-tests ls -la ./vendor"
//     docker.image("ca_testing").inside {
//       sh "ls -la"
//       sh "ls -la .."
//       sh "ls -la ./vendor/bundle/ruby/2.7.0/gems"
//     }
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
