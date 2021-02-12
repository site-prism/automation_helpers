# frozen_string_literal: true
RSpec.describe CaTesting::Patches::Logger do
  it_behaves_like "a patch" do
    subject { described_class.new(fake_logger.new) }

    let(:fake_logger) do
      Class.new do
        def initialize
          @logdev = OpenStruct.new(dev: fake_log_device.new)
        end

        def fake_log_device
          Struct.new(:foo) do
            def set_encoding(*_args)
              :bar
            end
          end
        end
      end
    end
  end
end
