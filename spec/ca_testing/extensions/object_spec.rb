# frozen_string_literal: true

describe Object do
  describe "#blank?" do
    subject(:object) { double }
    let(:nil?) { false }
    let(:empty?) { false }

    before do
      allow(object).to receive(:nil?).and_return(nil?)
      allow(object).to receive(:empty?).and_return(empty?)
    end

    context "with a nil object" do
      let(:nil?) { true }

      it { is_expected.to be_blank }
    end

    context "with an empty object" do
      let(:empty?) { true }

      it { is_expected.to be_blank }
    end

    context "with a non-empty object" do
      it { is_expected.not_to be_blank }
    end
  end
end
