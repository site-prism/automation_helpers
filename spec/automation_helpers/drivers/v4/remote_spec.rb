# frozen_string_literal: true

RSpec.describe CaTesting::Drivers::V4::Remote do
  before do
    Capybara.default_driver = :selenium
    described_class.new(browser).register
  end

  after(:each) { session.quit }

  subject(:options) { session.driver.options }

  let(:session) { Capybara::Session.new(:selenium) }

  describe "#register" do
    context "for chrome" do
      let(:browser) { :chrome }

      it "has correct top level properties" do
        expect(options.keys).to eq(%i[browser clear_local_storage clear_session_storage capabilities url])
      end

      it "has correct desired capabilities" do
        expect(options[:capabilities].first.as_json)
          .to eq(
            {
              "browserName" => "chrome",
              "goog:loggingPrefs" => {
                "browser" => "ALL",
                "driver" => "ALL"
              }
            }
          )
      end

      it "has correct browser options" do
        expect(options[:capabilities].last.as_json)
          .to eq(
            {
              "browserName" => "chrome",
              "goog:chromeOptions" => {}
            }
          )
      end
    end

    context "for firefox" do
      before { CaTesting::Patches::SeleniumOptions.new(browser).patch! }

      let(:browser) { :firefox }
      let(:caps) { options[:capabilities].first.as_json }
      let(:opts) { options[:capabilities].last.as_json }

      it "has correct top level properties" do
        expect(options.keys).to eq(%i[browser clear_local_storage clear_session_storage capabilities url])
      end

      it "has correct desired capabilities" do
        expect(caps).to eq({ "browserName" => "firefox" })
      end

      it "has correct browser options" do
        expect(opts).to match(a_hash_including("browserName" => "firefox"))

        expect(opts["moz:firefoxOptions"]).to match(a_hash_including("log" => { "level" => "trace" }))
      end
    end

    context "for an unsupported browser" do
      let(:browser) { :foo }

      it "doesn't work if the browser is not one of the supported browsers" do
        expect { options }.to raise_error(ArgumentError)
      end
    end
  end
end
