# frozen_string_literal: true

describe Capybara::Node::Element do
  subject(:capybara_element) { described_class.new(:_session, :_base, :_query_scope, :_query) }
  let(:selenium_element) { double(rect: rect) }
  let(:rect) { OpenStruct.new(x: 8, y: 29, width: 185, height: 21) }

  before { allow(capybara_element).to receive(:native).and_return(selenium_element) }

  describe "#horizontal_position" do
    it "returns the top-left horizontal ordinate from the native rect" do
      expect(capybara_element.horizontal_position).to eq(8)
    end
  end

  describe "#vertical_position" do
    it "returns the top-left vertical ordinate from the native rect" do
      expect(capybara_element.vertical_position).to eq(29)
    end
  end
end
