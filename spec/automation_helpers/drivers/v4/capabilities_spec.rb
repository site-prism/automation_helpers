# frozen_string_literal: true

RSpec.describe AutomationHelpers::Drivers::V4::Capabilities do
  describe '.for' do
    subject(:capabilities) { described_class.for(browser, device_options).as_json }

    let(:device_options) { {} }

    context 'with a valid device / android version' do
      let(:browser) { :android }
      let(:device_options) { { device_name: 'SamsungGalaxyS20', os_version: '10' } }

      it 'has correct android capabilities' do
        expect(capabilities).to eq(
          {
            'bstack:options' => {
              'deviceName' => 'SamsungGalaxyS20',
              'realMobile' => 'true',
              'appiumVersion' => '2.0.1'
            }
          }
        )
      end
    end

    context 'with an invalid android version' do
      let(:browser) { :android }
      let(:device_options) { { device_name: 'SamsungGalaxyS10', os_version: '8' } }

      it 'complains that the android version is invalid' do
        expect { capabilities }
          .to raise_error(ArgumentError)
          .with_message("Your Android Version is too low. Please don't use lower than Android Quince (10).")
      end
    end

    context 'when the browser is chrome' do
      let(:browser) { :chrome }

      it 'has correct chrome capabilities' do
        expect(capabilities).to eq(
          {
            'browserName' => 'chrome',
            'goog:loggingPrefs' => {
              'browser' => 'ALL',
              'driver' => 'ALL'
            }
          }
        )
      end
    end

    context 'when the browser is internet_explorer' do
      let(:browser) { :internet_explorer }

      it 'has correct internet explorer capabilities' do
        expect(capabilities).to eq(
          {
            'browserName' => 'internet explorer',
            'bstack:options' => {
              'ie' => {
                'driver' => '4.16.0.0',
                'arch' => 'x32'
              }
            }
          }
        )
      end
    end

    context 'with a valid device / iOS version' do
      let(:browser) { :ios }
      let(:device_options) { { device_name: 'iPhone15', os_version: '15' } }

      it 'has correct iOS capabilities' do
        expect(capabilities).to eq(
          {
            'bstack:options' => {
              'deviceName' => 'iPhone15',
              'realMobile' => 'true',
              'appiumVersion' => '2.4.1'
            }
          }
        )
      end
    end

    context 'with an invalid iOS version' do
      let(:browser) { :ios }
      let(:device_options) { { device_name: 'iPhone10', os_version: '12' } }

      it 'complains that the iOS version is invalid' do
        expect { capabilities }
          .to raise_error(ArgumentError)
          .with_message("Your iOS Version is too low. Please don't use lower than iOS 14.")
      end
    end

    context 'when the browser is anything else' do
      let(:browser) { :foo }

      it { is_expected.to be_empty }
    end
  end
end
