# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ca_testing/version"

Gem::Specification.new do |spec|
  spec.name          = "ca_testing"
  spec.version       = CaTesting::VERSION
  spec.authors       = ["Luke Hill"]
  spec.email         = %w[luke.hill@citizensadvice.org.uk]

  spec.summary       = "Citizens Advice - Testing"
  spec.description   = "Automation Patches / Extensions that allow you to extend your Ruby-based testing frameworks"
  spec.homepage      = "https://www.github.com/citizens-advice/ca_testing/"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://www.github.com/citizens-advice/ca_testing/"
  spec.metadata["changelog_uri"] = "https://www.github.com/citizens-advice/ca_testing/blob/main/CHANGELOG.md"

  spec.required_ruby_version = ">= 2.7"

  spec.files = Dir.glob("lib/**/*") + %w[LICENSE.txt README.md]

  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faraday", "~> 1.0"

  spec.add_development_dependency "capybara", "~> 3.27"
  spec.add_development_dependency "cucumber", [">= 5.0", "< 8"]
  spec.add_development_dependency "parallel_tests", "~> 3.7"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.10"
  spec.add_development_dependency "selenium-webdriver", [">= 4.0.0.alpha1", "< 4.0.0.beta5"]
  spec.add_development_dependency "webdrivers", "~> 4.6"
end
