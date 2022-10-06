# frozen_string_literal: true

describe Array do
  describe '.alphabet' do
    subject { described_class.alphabet }

    context 'with no argument provided - it defaults to upper case characters' do
      it { is_expected.to eq(('A'..'Z').to_a) }
    end

    context 'with upper case characters' do
      subject { described_class.alphabet(:upper) }

      it { is_expected.to eq(('A'..'Z').to_a) }
    end

    context 'with lower case characters' do
      subject { described_class.alphabet(:lower) }

      it { is_expected.to eq(('a'..'z').to_a) }
    end

    context 'with both upper and lower case characters' do
      subject { described_class.alphabet(:both) }

      it { is_expected.to eq(('a'..'z').to_a + ('A'..'Z').to_a) }
    end

    context 'with an invalid alphabet type' do
      subject(:invalid_alphabet_type) { described_class.alphabet(:foo) }

      it 'raises an error' do
        expect { invalid_alphabet_type }
          .to raise_error(ArgumentError)
          .with_message('Invalid alphabet type. Must be :upper (default), :lower or :both')
      end
    end
  end

  describe '#non_uniq' do
    subject { array.non_uniq }

    context 'with a blank array' do
      let(:array) { [] }

      it { is_expected.to eq([]) }
    end

    context 'with a unique array' do
      let(:array) { [nil, 1, :foo, Class.new] }

      it { is_expected.to eq([]) }
    end

    context 'with a non-unique array' do
      let(:array) { [nil, 1, :foo, :foo, Class.new] }

      it { is_expected.to eq([:foo]) }
    end
  end

  describe '#uniq?' do
    subject { array.uniq? }

    context 'with a blank array' do
      let(:array) { [] }

      it { is_expected.to be true }
    end

    context 'with a unique array' do
      let(:array) { [nil, 1, :foo, Class.new] }

      it { is_expected.to be true }
    end

    context 'with a non-unique array' do
      let(:array) { [nil, 1, :foo, :foo, Class.new] }

      it { is_expected.to be false }
    end
  end
end
