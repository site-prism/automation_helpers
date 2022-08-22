# frozen_string_literal: true

RSpec.shared_examples 'a patch' do
  before do
    allow(patch).to receive(:deprecate?).and_return(deprecate?)
    allow(patch).to receive(:prevent_usage?).and_return(prevent_usage?)
    allow(Kernel).to receive(:warn)
  end

  let(:deprecate?) { false }
  let(:prevent_usage?) { false }

  describe '#patch!' do
    context 'when permissible' do
      it 'performs the patch successfully' do
        expect(patch).to receive(:perform)

        patch.patch!
      end
    end

    context 'when deprecated' do
      let(:deprecate?) { true }

      it 'performs the patch successfully' do
        expect(patch).to receive(:perform)

        patch.patch!
      end

      it 'notifies the user that it is deprecated' do
        expect(Kernel).to receive(:warn).with('This is now deprecated and should not be used')

        patch.patch!
      end
    end

    context 'when EOL' do
      let(:prevent_usage?) { true }

      it 'raises an Error' do
        expect { patch.patch! }.to raise_error(RuntimeError).with_message('This is no longer supported')
      end
    end
  end
end
