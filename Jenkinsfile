node("docker && awsaccess") {
  cleanWs()
  checkout scm

  stage("build") {
    docker.build("automation_extensions")
  }

  docker.image("automation_extensions").inside {
    stage("unit test") {
      sh "bundle exec rubocop"
    }
    stage("unit test") {
      sh "bundle exec rspec"
    }
  }
}
