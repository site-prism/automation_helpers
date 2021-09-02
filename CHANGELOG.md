## <sub>main</sub>
#### _Unreleased_

## <sub>v3.0</sub>
#### _Unreleased_

**Breaking Changes**
* Altered format / structure of patches to accept either...
  * `#deprecation_notice_date` (Time) or `#deprecate_from` (Gem version)
  * `#prevent_usage_date` (Time) or `#prevent_usage_from` (Gem version)

* Rewrote public API of Browserstack Drivers
  * Uses a similar `.for` notation to the remote API.
  * Removes the need to provide the custom capabilities class (where it can be directly determined)

* New (private) API for Capabilities which mirrors Options

**New**
* Added **working** Browserstack-specific capabilities for Android driver (Previously were hard-coded and placeholder)

**Removals**
* Removed all Docker/Jenkins code as we now use GHA as our CI pipeline

**Changed**
* Amalgamation / Standardisation down of tests and namespaces
  * The previous v3 internet explorer namespace has been moved to v4 because it was actually a v4 driver

## <sub>v2.2</sub>
#### _Aug. 12, 2021_

**New**
* Added Parallel Tests patch
  * The converted order of the command line options passed to cucumber was incorrect

## <sub>v2.1</sub>
#### _Jul. 26, 2021_

**New**
* Added extension for `Capybara::Node::Element#stale?`

* Added Browserstack Base driver (capabilities / options)

## <sub>v2.0.1</sub>
#### _Jun. 18, 2021_

**Bugfixes**
* Fixed ios capabilities to accept a device name as well as an ios version

## <sub>v2.0</sub>
#### _Jun. 17, 2021_

**Breaking Changes**
* Options class refactors
  * Now is no longer directly instantiated -> `Options.new(browser)` becomes `Options.for(browser)`
  * Removed a few lines of redundant code that was duplicating some effort

**New**
* Added Browserstack-specific capabilities for drivers (Chrome, Android, Ios, Internet Explorer)

**Bugfixes**
  * Fixed an issue where requiring just the local v4 driver wouldn't work due to not `require`ing selenium capabilities

## <sub>v1.1</sub>
#### _May. 4, 2021_

**New**
* Added extensions for `Array#uniq?` and `Array#non_uniq`

## <sub>v1.0</sub>
#### _Mar. 24, 2021_

**Breaking Changes**
* Altered the Selenium Logger patch
  * No longer require an input logger object (Only operates on selenium logger)
  * Renamed the class to reflect the change

* Altered the dependency requirements of the gem
  * Selenium / Capybara are no longer required to make the gem work (They never were)
  * In order to perform the regular patching on selenium / capybara, you would still need them in that situation

**Removals**
* Removed sample patch code in preparation for first major release

**New**
* Added Selenium Cookie patch
  * The cookie converter algorithm inside Selenium wasn't bubbling up the `httpOnly` property

* Logging for this gem is now switched on by default (Level `:INFO`)

* Updated the gem to require Ruby 2.7+
  * This enables us to use the latest style guide changes from the citizens-advice-style-ruby gem

* Added extensions for `String#pascalize` and `String#snake_case`

* Added extensions for Cucumber
  * `Cucumber::Core::Test::Case#feature_file_name`
  * `Cucumber::Core::Test::Case#feature_file_path`

* Added extensions for Capybara
  * `Capybara::Node::Element#horizontal_position`
  * `Capybara::Node::Element#vertical_position`

**Updates**
* Updated gemspec
  * Don't expect feature files
  * Use latest rspec
  * Migrate all runtime dependencies to dev dependencies
    * Each of the patches / extensions are completely independent

**Bugfixes**
* Fixed Firefox log level to be the correct low-level one (`trace` not `info`)

## <sub>v0.4</sub>
#### _Feb. 22, 2021_

**New**
* Added sample code / specs for patches
  * This will now enable all future patches to conform to a sensible structure
  * Use shared examples to allow faster writing of new patch tests

* Added Logger patch
  * Selenium Webdriver Logger auto-writes when set to any level below `:WARN`. We need
  to ensure that when it writes it uses `binmode` to avoid encoding special characters

* Added Selenium Options patch
  * When using a Safari or Firefox driver, there was a bug where it didn't properly
  camelCase the `browserName` property when using both capabilities and options properties
  during driver creation

* Added Capybara Safari text patch
  * Due to Safari having lots of issues with their driver. The w3c standard endpoint
  that is used by driver consumers isn't returning correct text. This patches the already
  patched Capybara patch, to ensure all calls to `#text` return expected values

**Updates**
* The docker files are now slightly lighter
* LICENSE year update

## <sub>v0.3</sub>
#### _Jan. 15, 2021_

**New**
* Added remote (grid), driver creation

**Bugfixes**
* Add Local Safari driver tests
  * Previously these complained of an issue in missing browser / driver. This is now stubbed

## <sub>v0.2.1</sub>
#### _Jan. 11, 2021_

**New**
* Added CI pipeline to repo
* Added Logging functionality to gem. Currently set to de-activated (Unknown level by default)

**Bugfixes**
* Fixed Safari Capabilities creation on Local Driver
  * The v4 capabilities pass a 2-element array, but the STP usage was getting overwritten

* Fixed `.ruby-version` file forcing users to use `2.7.2` (When the gem supports v2.6 of ruby)

## <sub>v0.2</sub>
#### _Dec. 03, 2020_

**Breaking Changes**
* Rename of suite to `ca_testing`

**New**
* Added local driver creation

## <sub>v0.1</sub>
#### _Nov. 27, 2020_

**New**
* Added base changelog, versioning, and cut blank gem
* Made suite fully rubocop compliant with CA styles
* Dockerized suite
