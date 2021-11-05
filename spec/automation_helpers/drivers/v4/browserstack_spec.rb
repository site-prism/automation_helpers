# frozen_string_literal: true

RSpec.describe CaTesting::Drivers::V4::Browserstack do
  before do
    Capybara.default_driver = :selenium
    described_class.new(browser, browserstack_options).register
  end

  after(:each) { session.quit }

  subject(:options) { session.driver.options }

  let(:session) { Capybara::Session.new(:selenium) }
  let(:browserstack_options) do
    {
      build_name: "build",
      project_name: "project",
      session_name: "session",
      browserstack_debug_mode: "false",
      username: "username",
      api_key: "apikey123",
      config: "os_osversionnumber_browserversionnumber"
    }
  end
  let(:caps) { options[:capabilities].first.as_json }

  describe "#register" do
    let(:browser) { :foo }

    it "has correct desired capabilities" do
      expect(caps)
        .to eq(
          {
            "bstack:options" =>
              {
                "buildName" => "build",
                "projectName" => "project",
                "sessionName" => "session",
                "debug" => "false",
                "os" => "os",
                "osVersion" => "osversionnumber",
                "local" => "false",
                "seleniumVersion" => "4.0.0-alpha-6",
                "consoleLogs" => "verbose",
                "networkLogs" => "true",
                "resolution" => "1920x1080"
              },
            "browserVersion" => "browserversionnumber"
          }
        )
    end

    it "sets the hub url using the browserstack credentials" do
      expect(options[:url]).to eq("https://username:apikey123@hub-cloud.browserstack.com/wd/hub")
    end
  end
end
