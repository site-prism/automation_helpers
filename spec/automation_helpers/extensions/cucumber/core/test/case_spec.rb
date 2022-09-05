# frozen_string_literal: true

describe Cucumber::Core::Test::Case do
  subject(:test_case) { described_class.new(:_id, :_name, [:_test_steps], location, :_tags, :_language) }

  let(:location) { instance_double(Cucumber::Core::Test::Location, to_s: 'file/path/to/feature.feature:5') }

  describe '#feature_file_name' do
    it 'returns the name of the feature being ran' do
      expect(test_case.feature_file_name).to eq('feature')
    end
  end

  describe '#feature_file_path' do
    it 'returns the fully qualified file path of the feature being ran' do
      expect(test_case.feature_file_path).to eq('file/path/to/feature.feature:5')
    end
  end
end
