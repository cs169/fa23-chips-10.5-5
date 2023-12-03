# frozen_string_literal: true

# rubocop:disable RSpec/VerifiedDoubleReference

require 'rails_helper'

RSpec.describe Representative, type: :model do
  describe '.civic_api_to_representative_params' do
    before do
      # Create a representative in the database with a specific name
      described_class.create(name: 'John Doe', ocdid: 'ocdid_123', title: 'Mayor')
    end

    it 'does not create duplicate representatives' do
      # Mock representative data from the API with a duplicate name
      official = instance_double('official', name: 'John Doe', address: nil, party: nil, photo_url: nil)
      office = instance_double('office', name: 'Mayor', division_id: 'ocdid_456', official_indices: [0])
      rep_info = instance_double('rep_info', officials: [official], offices: [office])
      # Call the method
      described_class.civic_api_to_representative_params(rep_info)

      # Check that only one representative with the name 'John Doe' exists in the database
      expect(described_class.where(name: 'John Doe').count).to eq(1)
    end

    it 'creates a representatives' do
      # Mock representative data from the API with a duplicate name
      official = instance_double('official', name: 'Phil Er')

      office = instance_double('office', name: 'Mayor', division_id: 'ocdid_457', official_indices: [0])
      rep_info = instance_double('rep_info', officials: [official], offices: [office])
      # Call the method
      described_class.civic_api_to_representative_params(rep_info)

      # Check that only one representative with the name 'John Doe' exists in the database
      expect(described_class.where(name: 'Phil Er').count).to eq(1)
    end
  end
end

# rubocop:enable RSpec/VerifiedDoubleReference
