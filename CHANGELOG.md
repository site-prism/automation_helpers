## <sub>main</sub>
#### _Unreleased_

**Breaking Changes**

**Removals**

**New**

**Changes**
* Removed redundant `spec` code

**Updates**

**Bugfixes**

## <sub>v5.0.1</sub>
#### _Jan. 29, 2024_

**Updates**
* CI workflow now tests Ruby 3.3. Low spec gemfiles bumped accordingly

**Bugfixes**

## <sub>v5.0</sub>
#### _Aug. 17, 2023_

**Breaking Changes**
* The v4 local driver is now instantiated completely differently, with a different key and payload
  * This is to facilitate the switch to SM and also tidying up some deprecation notices
  * Remote / Browserstack drivers are unaffected

* Minimum ruby version is now `3.0`

* The `AutomationHelpers.logger` has now been massively simplified. Everything logs at `INFO` level now
  * You can't alter/detect the level of the logger (It's always INFO)
  * You can't overwrite / pipe the logger to a different object
  * You are still able to switch the `log_path` and decide where to pipe the existing log to

**Removals**
* The logger can no longer be customised, other than the `log_path`

* Some legacy code that was supporting old pre v4.0 selenium is now removed in internal tests

* Removed 3 patches from gem
  * `AutomationHelpers::Patches::ParallelCucumber` - which helped fix CLI args for cucumber in parallel has
    been deprecated for over a year, and banned from usage for the previous 6 months
  * `AutomationHelpers::Patches::SeleniumOptions` - which fixed some options not being cased right for
    firefox and safari drivers has been deprecated for 18 months, and banned from usage for the previous 12 months
  * `AutomationHelpers::Patches::SeleniumManager` - which fixed the `httpOnly` property of cookies not being made
    available has been deprecated for over 2 years, and banned from usage for the previous 18 months

**New**
* Edge can now be used as a remote browser in a dockerized grid

**Changes**
* Safari Capabilities are now just a vanilla `{}` as the STP driver name is correctly determined and set
by the `Selenium::WebDriver::Safari::Options` instance

* The appium versions usable are now unlocked all up to the final `v1.x` revision.
  * In accordance with this, the minimum iOS version supported is now v12 (Was v11)

* The CI now runs on the latest LTS version of Ubuntu, and latest bundler

* Selenium Manager is now exclusively used for all testing of browsers, accordingly `webdrivers` is no longer a dev dependency

* The legacy `headless!` helper has now been removed. Chrome/Edge now accordingly use the new `--headless=new` flag

**Updates**
* Rubocop updates across the suite of gems

**Bugfixes**
* Some of the device specs were slightly incorrect and are now realistic

## <sub>v4.1.1</sub>
#### _Aug. 16, 2023_

**New**
* Run CI for Ruby 3.2

* Add dependabot into repo

**Changes**
* All patches are now more unrestricted in the gemspec

**Bugfixes**
* `String.alphabet_char` was referencing `Array` extension 
  * Now runs of it's own volition so you won't get a `NoMethodError`

* Fix missing configuration for Safari Capabilities when running in remote or browserstack
  * NB: For now remote execution isn't possible as there isn't a grid image for this

* CI config for both workflows and dependabot was slightly incorrect

## <sub>v4.1</sub>
#### _Nov. 1, 2022_

**New**
* Added extension for `String#to_bool`

* Added extensions for `Array.alphabet` and `String.alphabet_char`
  * These take a single argument for the casing of the alphabet (Defaults to upper case by default)

**Changes**
* Fixed up all outstanding cop offenses for rubocop (And bumped all rubocop gems)

* Fixed an issue where the CI flows weren't switching ruby correctly

## <sub>v4.0.1</sub>
#### _Aug. 22, 2022_

**New**
* Added in new rubocop subgems
  * Existing rubocop config has been slightly amended to avoid long arrays/hashes breaking the rules
  * TODO file re-generated (and partially fixed), to show what other cop offenses need tackling
  * Updated `rubocop` to a later version

**Changes**
* Updated testing matrix for CI
  * Removed selenium alpha testing, added ruby 3.1

* Removed all references to beta versions in `#deprecate_from` and `#prevent_usage_from` in patches

* `parallel_cucumber` now references a version instead of a date for `#deprecate_from` which is of a similar time

* Fixed some documentation in `SeleniumOptions` patch

## <sub>v4.0</sub>
#### _Nov. 19, 2021_

**Breaking Changes**
* Gem has been renamed to `automation_helpers` to facilitate move to fully OSS
  * All namespaces will need to be updated: **See 
    [HERE](https://github.com/site-prism/automation_helpers/blob/main/UPGRADING.md) for details**
  * Usage of all specs now reflects new name
  * New License (Moved to BSD-3-Clause in line with other SitePrism frameworks)
  * New style guide based on standard rubocop (Still some issues to fix)

**New**
* Added new extension to Selenium Logs to improve Console Logging
  * Console Logging is now non-destructive and all logs when fetched are cached (To be later written to a file)
  * Console Logging can piped to a file or `$stdout` Using `#write_log_to_file`

**Bugfixes**
* Fix `require` errors in Driver registration process
  * Some of the internal nested selenium code (Options / Capabilities e.t.c.), is not supported to be loaded
  individually and instead should be loaded as a full package

## <sub>v3.0.2</sub>
#### _Sep. 20, 2021_

**Removals**
* As we're using GHA we don't need rake tasks anymore
  * `rake` is no longer a dev dependency

**New**
* Added testing for a matrix of ruby / selenium versions
  * Initially we're testing alpha/beta/latest versions of selenium against ruby 2.7 and 3.0

* Added Local Edge driver tests
  * Previously, there weren't any tests for Edge driver

**Bugfixes**
* Fix Load error in Edge Options
  * Mac Edge was not properly processing the browser name by default
  
## <sub>v3.0.1</sub>
#### _Sep. 07, 2021_

**Bugfixes**
* Fixed load error in Selenium Webdriver Edge
  * This issue was due to Selenium changing their path for Edge Options during the V4 betas
  
## <sub>v3.0</sub>
#### _Sep. 02, 2021_

**Breaking Changes**
* Altered format / structure of patches to accept either...
  * `#deprecation_notice_date` (Time) or `#deprecate_from` (Gem version)
  * `#prevent_usage_date` (Time) or `#prevent_usage_from` (Gem version)

* Rewrote public API of Browserstack Drivers
  * Uses a similar `.for` notation to the remote API.
  * Removes the need to provide the custom capabilities class (where it can be directly determined)

* New (private), API for Capabilities which mirrors Options

**Removals**
* Removed all Docker/Jenkins code as we now use GHA as our CI pipeline

**New**
* Added **working** Browserstack-specific capabilities for Android driver (Previously were hard-coded and placeholder)

**Changes**
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
* Fixed iOS capabilities to accept a device name as well as an ios version

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
  * This enables us to use the latest style guide changes from the `citizens-advice-style-ruby` gem

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
