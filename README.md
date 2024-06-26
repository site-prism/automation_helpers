# Automation Helpers

#### The new OSS name for the gem formerly known as ca_testing

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
gem 'automation_helpers'
```

And then execute:

```shell
$ bundle
```

## Usage

Either require all of the extensions required, or require individual bits and pieces

```shell
# Require all of the drivers/patches/extensions code
require 'automation_helpers'
# Require all driver code
require 'automation_helpers/drivers'
# Require just local drivers
require 'automation_helpers/drivers/local'
# Require all patches
require 'automation_helpers/patches'
# Require all extensions
require 'automation_helpers/extensions'
```

## Development

```
$ bundle
# Code anything relevant - Add tests for each public method!
$ rspec && rubocop
# Ensure it's all green! Then commit and push
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/site-prism/automation_helpers

## Verbose Documentation

This will come in time. Meanwhile if you check the gem code most methods are
documented. Also check the specs for more detailed information
