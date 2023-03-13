# frozen_string_literal: true

RSpec.describe AutomationHelpers::Drivers::V4::Options do
  describe '.for' do
    subject(:options) { described_class.for(browser) }

    context 'when the browser is chrome' do
      let(:browser) { :chrome }

      it { is_expected.to have_attributes({ browser_name: 'chrome' }) }
    end

    context 'when the browser is firefox' do
      let(:browser) { :firefox }

      it { is_expected.to have_attributes({ browser_name: 'firefox', log: { level: 'trace' } }) }
    end

    context 'when the browser is internet explorer' do
      let(:browser) { :internet_explorer }

      it { is_expected.to have_attributes({ native_events: true, persistent_hover: true }) }
    end

    context 'when the browser is safari' do
      let(:browser) { :safari }

      context 'when Safari TP is active' do
        before do
          Selenium::WebDriver::Safari::Options::BROWSER = 'safari'
        end

        it do
          is_expected.to have_attributes({ browser_name: 'safari', automatic_inspection: true })
        end
      end

      context 'when Safari TP is not active' do
        before do
          Selenium::WebDriver::Safari::Options::BROWSER = 'Safari Technology Preview'
        end

        it { is_expected.to have_attributes({ browser_name: 'Safari Technology Preview', automatic_inspection: true }) }
      end
    end

    context 'when the browser is edge' do
      let(:browser) { :edge }

      it { is_expected.to have_attributes({ browser_name: 'MicrosoftEdge' }) }
    end

    context 'when the browser is headless' do
      before { allow(described_class).to receive(:headless?).and_return(true) }

      let(:browser) { :chrome }

      it { is_expected.to have_attributes({ args: ['--headless'] }) }
    end

    context 'when the browser is anything else' do
      let(:browser) { :foo }

      it { is_expected.to be_empty }
    end
  end
end
