# frozen_string_literal: true
RSpec.describe CaTesting::Patches::SeleniumOptions do
  context "with firefox" do
    it_behaves_like "a patch" do
      subject { described_class.new(:firefox) }
    end
  end

  context "with safari" do
    it_behaves_like "a patch" do
      subject { described_class.new(:safari) }
    end
  end

  context "with anything else" do
    subject { described_class.new(:foo) }

    it "does not perform the patch" do
      expect(subject).not_to receive(:perform)

      subject.patch!
    end
  end
end
