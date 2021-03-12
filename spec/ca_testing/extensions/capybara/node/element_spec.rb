# frozen_string_literal: true

describe Capybara::Node::Element do
  before(:each) { visit("/sample_page.html") }

  let(:element) { page.find("input") }

  describe "#horizontal_position" do
    it "returns the top-left horizontal ordinate from the native rect" do
      expect(element.horizontal_position).to eq(8)
    end
  end

  describe "#vertical_position" do
    it "returns the top-left vertical ordinate from the native rect" do
      expect(element.vertical_position).to eq(29)
    end
  end
end
