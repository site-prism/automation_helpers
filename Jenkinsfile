node("docker && awsaccess") {
  cleanWs()
  checkout scm

  stage("Build Image") {
    docker.build("ca_testing")
  }

  docker.image("ca_testing").inside {
    stage("Lint and Unit Test") {
      sh "bundle exec rake"
    }
  }
}
