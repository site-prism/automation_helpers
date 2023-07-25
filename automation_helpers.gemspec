# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'automation_helpers/version'

Gem::Specification.new do |spec|
  spec.name          = 'automation_helpers'
  spec.version       = AutomationHelpers::VERSION
  spec.authors       = ['Luke Hill', 'Marcelo Nicolosi Santos']
  spec.email         = %w[lukehill_uk@hotmail.com celonicolosi@hotmail.com]

  spec.summary       = 'Automation Helpers - Avoid writing the most common things in Ruby Automation'
  spec.description   = 'Automation Patches / Extensions that allow you to extend your Ruby-based testing frameworks'
  spec.homepage      = 'https://www.github.com/site-prism/automation_helpers'
  spec.license       = 'BSD-3-Clause'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://www.github.com/site-prism/automation_helpers'
  spec.metadata['changelog_uri'] = 'https://www.github.com/site-prism/automation_helpers/blob/main/CHANGELOG.md'

  spec.required_ruby_version = '>= 2.7'

  spec.files = Dir.glob('lib/**/*') + %w[LICENSE.txt README.md]

  spec.require_paths = ['lib']

  spec.add_development_dependency 'capybara', ['>= 3.30', '< 4']
  spec.add_development_dependency 'cucumber', ['>= 7.0', '< 9']
  spec.add_development_dependency 'faraday', '~> 2.7'
  spec.add_development_dependency 'parallel_tests', ['>= 3.7', '< 5']
  spec.add_development_dependency 'rspec', '~> 3.12'
  spec.add_development_dependency 'rubocop', '~> 1.55.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.18.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.22.0'
  spec.add_development_dependency 'selenium-webdriver', ['>= 4.0', '< 5']
  spec.add_development_dependency 'webdrivers', '~> 5.2'
end
