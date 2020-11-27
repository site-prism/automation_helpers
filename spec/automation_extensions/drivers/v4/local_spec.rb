# frozen_string_literal: true
RSpec.describe AutomationExtensions::Drivers::V4::Local do
  before do
    Capybara.default_driver = :selenium
    described_class.new(browser).register
  end

  let(:session) { Capybara::Session.new(:selenium) }

  describe "#register" do
    context "for chrome" do
      let(:browser) { :chrome }

      it "has correct top level properties" do
        expect(session.driver.options.keys)
          .to eq(
            %i[browser clear_local_storage clear_session_storage service capabilities]
          )
      end

      it "has correct desired capabilities" do
        expect(session.driver.options[:capabilities].first.as_json).to eq({})
      end

      it "has correct browser options" do
        expect(session.driver.options[:capabilities].last.as_json)
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
        expect(session.driver.options.keys)
          .to eq(
            %i[browser clear_local_storage clear_session_storage service capabilities]
          )
      end

      it "has correct desired capabilities" do
        expect(session.driver.options[:capabilities].first.as_json).to eq({})
      end

      it "has correct browser options" do
        expect(session.driver.options[:capabilities].last.as_json)
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
      let(:options) { session.driver.options }

      it "has correct top level properties" do
        expect(options.keys)
          .to eq(
            %i[browser clear_local_storage clear_session_storage service capabilities]
          )
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

    context "for safari" do
      let(:browser) { :safari }

      it "has correct top level properties" do
        expect(current_driver.options.keys)
          .to eq(
            %i[browser clear_local_storage clear_session_storage service capabilities]
          )
      end

      it "has correct desired capabilities" do
        expect(current_driver.options[:capabilities].first.as_json).to eq({})
      end

      it "has correct browser options" do
        expect(current_driver.options[:capabilities].last.as_json)
          .to eq(
            {
              "browserName" => "chrome",
              "goog:chromeOptions" => {}
            }
          )
      end
    end

    context "for ios" do
      let(:browser) { :ios }

      it "has correct top level properties" do
        expect(current_driver.options.keys)
          .to eq(
            %i[browser clear_local_storage clear_session_storage service capabilities]
          )
      end

      it "has correct desired capabilities" do
        expect(current_driver.options[:capabilities].first.as_json).to eq({})
      end

      it "has correct browser options" do
        expect(current_driver.options[:capabilities].last.as_json)
          .to eq(
            {
              "browserName" => "chrome",
              "goog:chromeOptions" => {}
            }
          )
      end

      it { is_expected.to be_empty }
    end

    context "for android" do
      let(:browser) { :android }

      it "has correct top level properties" do
        expect(current_driver.options.keys)
          .to eq(
            %i[browser clear_local_storage clear_session_storage service capabilities]
          )
      end

      it "has correct desired capabilities" do
        expect(current_driver.options[:capabilities].first.as_json).to eq({})
      end

      it "has correct browser options" do
        expect(current_driver.options[:capabilities].last.as_json)
          .to eq(
            {
              "browserName" => "chrome",
              "goog:chromeOptions" => {}
            }
          )
      end

      it { is_expected.to be_empty }
    end

    context "for an unsupported browser" do
      let(:browser) { :foo }

      it "Doesn't work if the browser is not one of the supported browsers" do
        expect { current_driver.options }.to raise_error(NoMethodError)
      end
    end
  end
end
