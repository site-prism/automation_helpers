# frozen_string_literal: true
RSpec.describe AutomationExtensions::Drivers::V4::Local do
  before do
    Capybara.default_driver = :selenium
    described_class.new(browser).register
  end

  let(:session) { Capybara::Session.new(:selenium) }
  let(:options) { session.driver.options }

  describe "#register" do
    context "for chrome" do
      let(:browser) { :chrome }

      it "has correct top level properties" do
        expect(options.keys).to eq(%i[browser clear_local_storage clear_session_storage service capabilities])
      end

      it "has correct desired capabilities" do
        expect(options[:capabilities].first.as_json).to eq({})
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
      let(:browser) { :firefox }

      it "has correct top level properties" do
        expect(options.keys).to eq(%i[browser clear_local_storage clear_session_storage service capabilities])
      end

      it "has correct desired capabilities" do
        expect(options[:capabilities].first.as_json).to eq({})
      end

      it "has correct browser options" do
        expect(options[:capabilities].last.as_json)
          .to eq(
            {
              "browserName" => "firefox",
              "moz:firefoxOptions" => { "log" => { "level" => "info" } }
            }
          )
      end
    end

    context "for internet explorer" do
      let(:browser) { :internet_explorer }

      it "has correct top level properties" do
        expect(options.keys).to eq(%i[browser clear_local_storage clear_session_storage service capabilities])
      end

      it "has correct desired capabilities" do
        expect(options[:capabilities].first.as_json).to eq({})
      end

      it "has correct (Modified), browser options" do
        expect(options[:capabilities].last.as_json)
          .to eq(
            {
              "se:ieOptions" => { "enablePersistentHover" => true, "nativeEvents" => true }
            }
          )
      end
    end

    context "for an unsupported browser" do
      let(:browser) { :foo }

      it "Doesn't work if the browser is not one of the supported browsers" do
        expect { options }.to raise_error(NoMethodError)
      end
    end
  end
end
