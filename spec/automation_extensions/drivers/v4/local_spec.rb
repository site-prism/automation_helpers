# frozen_string_literal: true
RSpec.describe AutomationExtensions::Drivers::V4::Local do
  let(:local_driver_class) { described_class.new(browser) }
  let(:current_driver) { Capybara.current_session.driver }

  before { Capybara.default_driver = :selenium }
  before { local_driver_class.register }

  describe "#register" do
    context "for chrome" do
      let(:browser) { :chrome }
      
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

    context "for firefox" do
      let(:browser) { :firefox }

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

    context "for internet explorer" do
      let(:browser) { :internet_explorer }

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

      it { is_expected.to have_attributes({ native_events: true, persistent_hover: true }) }
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

      it { is_expected.to have_attributes({ browser_name: "safari", automatic_inspection: true }) }
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
