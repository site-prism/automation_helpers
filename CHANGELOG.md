## <sub>main</sub>
#### _N/A_

**Breaking Changes**
* Altered the Selenium Logger patch
  * No longer require an input logger object (Only operates on selenium logger)
  * Renamed the class to reflect the change

**Removals**
* Removed sample patch code in preparation for first major release

**New**
* Added Selenium Cookie patch
  * The cookie converter algorithm inside Selenium wasn't bubbling up the `httpOnly` property
  
* Logging for this gem is now switched on by default (Level `:INFO`)

* Added extensions for `String#pascalize`, `String#snake_case` and `Object#blank?`

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
#### _Feb. 22, 2020_

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
#### _Jan. 15, 2020_

**New**
* Added remote (grid), driver creation

**Bugfixes**
* Add Local Safari driver tests
  * Previously these complained of an issue in missing browser / driver. This is now stubbed

## <sub>v0.2.1</sub>
#### _Jan. 11, 2020_

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
