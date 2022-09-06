# frozen_string_literal: true

RSpec.describe AutomationHelpers::Drivers::V4::Local do
  subject(:options) { session.driver.options }

  before do
    Capybara.default_driver = :selenium
    described_class.new(browser).register
  end

  after { session.quit }

  let(:session) { capybara_session(:selenium) }
  let(:standard_top_level_properties) { %i[browser clear_local_storage clear_session_storage service capabilities] }

  describe '#register' do
    context 'when the browser is chrome' do
      let(:browser) { :chrome }

      it 'has correct top level properties' do
        expect(options.keys).to eq(standard_top_level_properties)
      end

      it 'has correct desired capabilities' do
        expect(options[:capabilities].first.as_json).to eq({})
      end

      it 'has correct browser options' do
        expect(options[:capabilities].last.as_json)
          .to eq(
            {
              'browserName' => 'chrome',
              'goog:chromeOptions' => {}
            }
          )
      end
    end

    context 'when the browser is firefox' do
      before do
        AutomationHelpers::Patches::SeleniumOptions.new(browser).patch! if run_selenium_options_patch?
      end

      let(:browser) { :firefox }

      it 'has correct top level properties' do
        expect(options.keys).to eq(standard_top_level_properties)
      end

      it 'has correct desired capabilities' do
        expect(options[:capabilities].first.as_json).to eq({})
      end

      it 'has correct browser options' do
        expect(options[:capabilities].last.as_json)
          .to match(
            a_hash_including(
              'browserName' => 'firefox',
              'moz:firefoxOptions' => hash_including({ 'log' => { 'level' => 'trace' } })
            )
          )
      end
    end

    context 'when the browser is internet explorer' do
      let(:browser) { :internet_explorer }

      it 'has correct top level properties' do
        expect(options.keys).to eq(standard_top_level_properties)
      end

      it 'has correct desired capabilities' do
        expect(options[:capabilities].first.as_json).to eq({})
      end

      it 'has correct (Modified), browser options' do
        expect(options[:capabilities].last.as_json)
          .to eq(
            {
              'se:ieOptions' => { 'enablePersistentHover' => true, 'nativeEvents' => true }
            }
          )
      end
    end

    context 'when the browser is safari' do
      before do
        AutomationHelpers::Patches::SeleniumOptions.new(browser).patch! if run_selenium_options_patch?
        # Prevent OS complaining it doesn't know where safari is!
        allow(Selenium::WebDriver::Platform).to receive(:assert_executable)
      end

      let(:browser) { :safari }

      it 'has correct top level properties' do
        expect(options.keys).to eq(standard_top_level_properties)
      end

      it 'has correct desired capabilities' do
        expect(options[:capabilities].last.as_json).to eq({ 'browserName' => 'Safari Technology Preview' })
      end

      it 'has correct browser options' do
        expect(options[:capabilities].first.as_json)
          .to eq(
            {
              'browserName' => 'safari',
              'safari:automaticInspection' => true
            }
          )
      end
    end

    context 'when the browser is edge' do
      let(:browser) { :edge }

      it 'has correct top level properties' do
        expect(options.keys).to eq(standard_top_level_properties)
      end

      it 'has correct desired capabilities' do
        expect(options[:capabilities].first.as_json).to eq({})
      end

      it 'has correct browser options' do
        expect(options[:capabilities].last.as_json)
          .to eq(
            {
              'browserName' => 'MicrosoftEdge',
              'ms:edgeOptions' => {}
            }
          )
      end
    end
  end
end
