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

    context "with special characters" do
      let(:string) { "foo %!$'" }

      it { is_expected.to eq("Foo %!$'") }
    end
  end

  describe "#snake_case" do
    subject { string.snake_case }

    context "with an all upcase string" do
      let(:string) { "FOOBARBAZ" }

      it { is_expected.to eq("foobarbaz") }
    end

    context "with an all lowercase string" do
      let(:string) { "foobarbaz" }

      it { is_expected.to eq("foobarbaz") }
    end

    context "with a pascalized string" do
      let(:string) { "FooBarBaz" }

      it { is_expected.to eq("foo_bar_baz") }
    end

    context "with numbers" do
      let(:string) { "FooBar123Baz" }

      it { is_expected.to eq("foo_bar123_baz") }
    end

    context "with apostrophe's" do
      let(:string) { "FooBar'sBaz" }

      it { is_expected.to eq("foo_bars_baz") }
    end

    context "with hyphen's" do
      let(:string) { "FooBar-Baz" }

      it { is_expected.to eq("foo_bar_baz") }
    end

    context "with multiple space's" do
      let(:string) { "Foo  Bar   Baz Today" }

      it { is_expected.to eq("foo_bars_baz_today") }
    end
  end
end
