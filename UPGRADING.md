# Upgrading from ca_testing 3.x to automation_helpers 4.x

## Name

The name of the gem changed from version 3.x to 4.x

As such you need to alter all your default namespaces from `CaTesting` to `AutomationHelpers`

```ruby
# Setting logger level
CaTesting.logger.level = :INFO
# Registering a local driver
CaTesting::Drivers::Local.new(browser).register
# Patching capybara
CaTesting::Patches::Capybara.new.patch!
```

now becomes ...

```ruby
# Setting logger level
AutomationHelpers.logger.level = :INFO
# Registering a local driver
AutomationHelpers::Drivers::Local.new(browser).register
# Patching capybara
AutomationHelpers::Patches::Capybara.new.patch!
```

## Selenium-Webdriver support

Previously in 3.x we only supported the pre-release versions of selenium 4. We now support the full
version 4 of selenium-webdriver (As well as the pre-release versions).

Note as version 4 is still reasonably new, it's likely some interop issues may be observed. Watch this
space for any associated patches that may come out accordingly.

## Configurable Logger

Previously `ca_testing` had a verbose logger

```ruby
  CaTesting.logger.info('This is an informative message')
```

now becomes ...

```ruby
  AutomationHelpers.logger.info('This is an informative message')
```

In the same way as the other items did.
