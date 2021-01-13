# frozen_string_literal: true
RSpec.describe CaTesting::Drivers::V4::Remote do
  before do
    Capybara.default_driver = :selenium
    described_class.new(browser).register
  end

  subject(:options) { session.driver.options }

  let(:session) { Capybara::Session.new(:selenium) }

  describe "#register" do
    context "for chrome" do
      let(:browser) { :chrome }

      it "has correct top level properties" do
        expect(options.keys).to eq(%i[browser clear_local_storage clear_session_storage capabilities url])
      end

      it "has correct desired capabilities" do
        expect(options[:capabilities].first.as_json).to eq({ "browserName" => "chrome" })
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
        expect(options.keys).to eq(%i[browser clear_local_storage clear_session_storage capabilities url])
      end

      it "has correct desired capabilities" do
        expect(options[:capabilities].first.as_json).to eq({ "browserName" => "firefox" })
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

    context "for an unsupported browser" do
      let(:browser) { :foo }

      it "doesn't work if the browser is not one of the supported browsers" do
        expect { options }.to raise_error(ArgumentError)
      end
    end
  end
end
