# Citizens Advice - Automation Extensions

This package will allow you to extend your automated testing frameworks with the following
- Driver creation: Allowing you to simply reference your drivers with a simple method
(**No more confusing capability classes / methods**)
- Simple extensions to regular classes (A bit like ActiveSupport where it's needed / common)
- Extensions to the commonly used Automation Packages (Selenium / Capybara e.t.c.), DSL's
(Think of things like enhancing `Capybara::Node::Element` e.t.c.)
- Patches required to allow instant fixing of bugs in upstream repos whilst fixes are
in PR and being reviewed / merged

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ca-ca_testing'
```

And then execute:

    $ bundle

## Usage

Either require all of the extensions required, or require individual bits and pieces

## Development

```
$ bundle
# Code anything relevant - Add tests for each public method!
$ bundle exec rake
# Ensure it's all green! Then commit and push
```

To release a new version, update the version number in `version.rb`, and then create a release
branch where the new version can be tagged and cut on github.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/citizens-advice/ca-automation_extensions

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
