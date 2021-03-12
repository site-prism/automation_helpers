# frozen_string_literal: true

describe String do
  describe "#pascalize" do
    subject { string.pascalize }

    context "with a space separated string" do
      let(:string) { "foo bar baz" }

      it { is_expected.to eq("Foo bar baz") }
    end

    context "with an underscore separated string" do
      let(:string) { "foo_bar_baz" }

      it { is_expected.to eq("FooBarBaz") }
    end
  end
end
