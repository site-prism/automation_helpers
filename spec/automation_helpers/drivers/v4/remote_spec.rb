# frozen_string_literal: true

RSpec.describe AutomationHelpers::Drivers::V4::Remote do
  subject(:options) { session.driver.options }

  before do
    stub_const('ENV', { 'HUB_URL' => 'localhost' })
    Capybara.default_driver = :selenium
    described_class.new(browser).register
  end

  after { session.quit }

  let(:session) { capybara_session(:selenium) }

  describe '#register' do
    context 'when the browser is chrome' do
      let(:browser) { :chrome }

      it 'has correct top level properties' do
        expect(options.keys).to eq(%i[browser clear_local_storage clear_session_storage capabilities url])
      end

      it 'has correct desired capabilities' do
        expect(options[:capabilities].first.as_json)
          .to eq(
            {
              'browserName' => 'chrome',
              'goog:loggingPrefs' => {
                'browser' => 'ALL',
                'driver' => 'ALL'
              }
            }
          )
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
      let(:browser) { :firefox }

      it 'has correct top level properties' do
        expect(options.keys).to eq(%i[browser clear_local_storage clear_session_storage capabilities url])
      end

      it 'has correct desired capabilities' do
        expect(options[:capabilities].first.as_json).to eq({ 'browserName' => 'firefox' })
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

    context 'when the browser is edge' do
      let(:browser) { :edge }

      it 'has correct top level properties' do
        expect(options.keys).to eq(%i[browser clear_local_storage clear_session_storage capabilities url])
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

    context 'when the browser is anything else' do
      let(:browser) { :foo }

      it 'fails as the browser is unsupported' do
        expect { options }.to raise_error(ArgumentError).with_message('You must use a supported browser')
      end
    end
  end
end
