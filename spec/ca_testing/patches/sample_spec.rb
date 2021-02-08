# frozen_string_literal: true
RSpec.describe CaTesting::Patches::Sample do
  before do
    allow(subject).to receive(:deprecate?).and_return(deprecate?)
    allow(subject).to receive(:prevent_usage?).and_return(prevent_usage?)
  end

  describe "#patch!" do
    context "when permissible" do
      let(:deprecate?) { false }
      let(:prevent_usage?) { false }

      it "performs the patch successfully" do
        expect { subject.patch! }.to change { subject.instance_variable_get(:@changed_behaviour) }
      end
    end

    context "when deprecated" do
      let(:deprecate?) { true }
      let(:prevent_usage?) { false }

      it "performs the patch successfully" do
        expect { subject.patch! }.to change { subject.instance_variable_get(:@changed_behaviour) }
      end

      it "notifies the user that it is deprecated" do
        expect(Kernel).to receive(:warn).with("This is now deprecated and should not be used")

        subject.patch!
      end
    end

    context "when EOL" do
      let(:deprecate?) { true }
      let(:prevent_usage?) { true }

      it "raises an Error" do
        expect { subject.patch! }.to raise_error(RuntimeError).with_message("This is no longer supported")
      end

      it "does not attempt to patch any files" do
        expect(subject).not_to receive(:perform)

        subject.patch!
      end
    end
  end
end
