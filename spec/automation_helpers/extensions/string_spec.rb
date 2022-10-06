# frozen_string_literal: true

describe String do
  describe '.alphabet_char' do
    subject { described_class.alphabet_char }

    context 'with no argument provided - it defaults to upper case characters' do
      it { is_expected.to match(/[A-Z]/) }
    end

    context 'with upper case characters' do
      subject { described_class.alphabet_char(:upper) }

      it { is_expected.to match(/[A-Z]/) }
    end

    context 'with lower case characters' do
      subject { described_class.alphabet_char(:lower) }

      it { is_expected.to match(/[a-z]/) }
    end

    context 'with both upper and lower case characters' do
      subject { described_class.alphabet_char(:both) }

      it { is_expected.to match(/[a-zA-Z]/) }
    end

    context 'with an invalid alphabet type' do
      subject(:invalid_alphabet_type) { described_class.alphabet_char(:foo) }

      it 'raises an error' do
        expect { invalid_alphabet_type }
          .to raise_error(ArgumentError)
          .with_message('Invalid alphabet type. Must be :upper (default), :lower or :both')
      end
    end
  end

  describe '#pascalize' do
    subject { string.pascalize }

    context 'with a space separated string' do
      let(:string) { 'foo bar baz' }

      it { is_expected.to eq('Foo bar baz') }
    end

    context 'with an underscore separated string' do
      let(:string) { 'foo_bar_baz' }

      it { is_expected.to eq('FooBarBaz') }
    end

    context 'with special characters' do
      let(:string) { "foo %!$'" }

      it { is_expected.to eq("Foo %!$'") }
    end
  end

  describe '#sanitize_whitespace' do
    subject { string.sanitize_whitespace }

    context 'with an a non-spaced string' do
      let(:string) { 'foobarbaz' }

      it { is_expected.to eq('foobarbaz') }
    end

    context 'with special characters string' do
      let(:string) { 'foo%!$#' }

      it { is_expected.to eq('foo%!$#') }
    end

    context 'with a regular spaced string' do
      let(:string) { 'foo bar baz' }

      it { is_expected.to eq('foo bar baz') }
    end

    context 'with an irregular spaced string' do
      let(:string) { 'foo   bar      baz' }

      it { is_expected.to eq('foo   bar      baz') }
    end

    context 'with other types of space characters' do
      let(:string) { "foo\f\tbar\r\fbaz" }

      it { is_expected.to eq('foo  bar  baz') }
    end

    context 'with non-breaking whitespace (NBSP), characters' do
      let(:string) { "foo\u00A0bar\u00A0baz" }

      it { is_expected.to eq('foo bar baz') }
    end

    context 'with new-line characters' do
      let(:string) { "foo\nbar\nbaz" }

      it { is_expected.to eq("foo\nbar\nbaz") }
    end
  end

  describe '#snake_case' do
    subject { string.snake_case }

    context 'with an all upcase string' do
      let(:string) { 'FOOBARBAZ' }

      it { is_expected.to eq('foobarbaz') }
    end

    context 'with an all lowercase string' do
      let(:string) { 'foobarbaz' }

      it { is_expected.to eq('foobarbaz') }
    end

    context 'with a pascalized string' do
      let(:string) { 'FooBarBaz' }

      it { is_expected.to eq('foo_bar_baz') }
    end

    context 'with numbers' do
      let(:string) { 'FooBar123Baz' }

      it { is_expected.to eq('foo_bar123_baz') }
    end

    context "with apostrophe's" do
      let(:string) { "FooBar'sBaz" }

      it { is_expected.to eq('foo_bars_baz') }
    end

    context "with hyphen's" do
      let(:string) { 'FooBar-Baz' }

      it { is_expected.to eq('foo_bar_baz') }
    end

    context "with multiple space's" do
      let(:string) { 'Foo  Bar   Baz Today' }

      it { is_expected.to eq('foo_bar_baz_today') }
    end
  end

  describe '#to_bool' do
    subject { string.to_bool }

    context 'with yes' do
      let(:string) { 'yes' }

      it { is_expected.to be true }
    end

    context 'with true' do
      let(:string) { 'true' }

      it { is_expected.to be true }
    end

    context 'with on' do
      let(:string) { 'on' }

      it { is_expected.to be true }
    end

    context 'with YES' do
      let(:string) { 'YES' }

      it { is_expected.to be true }
    end

    context 'with TRUE' do
      let(:string) { 'TRUE' }

      it { is_expected.to be true }
    end

    context 'with ON' do
      let(:string) { 'ON' }

      it { is_expected.to be true }
    end

    context 'with any other string' do
      let(:string) { SecureRandom.alphanumeric(rand(20)) }

      it { is_expected.to be false }
    end
  end
end
