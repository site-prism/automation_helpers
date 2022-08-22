# frozen_string_literal: true

describe Array do
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
end
