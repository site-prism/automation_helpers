## <sub>main</sub>
#### _N/A_

**Breaking Changes**
*

**Removals**
*

**New**
* Added sample code / specs for patches
  * This will now enable all future patches to conform to a sensible structure

**Updates**
* The docker files are now slightly lighter
* LICENSE year update

**Bugfixes**
*

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
