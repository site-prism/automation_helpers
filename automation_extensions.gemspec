
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "automation_extensions/version"

Gem::Specification.new do |spec|
  spec.name          = "automation_extensions"
  spec.version       = AutomationExtensions::VERSION
  spec.authors       = ["Luke Hill"]
  spec.email         = %w[luke.hill@citizensadvice.org.uk]

  spec.summary       = "Citizens Advice - Automation Extensions"
  spec.description   = "Automation Patches / Extensions that allow you to extend your Ruby-based testing frameworks"
  spec.homepage      = "https://www.github.com/citizens-advice/automation_extensions/"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://www.github.com/citizens-advice/automation_extensions/"
  spec.metadata["changelog_uri"] = "https://www.github.com/citizens-advice/automation_extensions/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
