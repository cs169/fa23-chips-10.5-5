# frozen_string_literal: true

require 'rails_helper'
require 'webmock/rspec'

RSpec.describe CampaignFinance, type: :model do
  describe '.get_top_20_candidates' do
    let(:valid_json_body) do
      '{"results": [{"name": "Candidate1", "party": "Party1"}, {"name": "Candidate2", "party": "Party2"}]}'
    end

    let(:expected_results) do
      [{ 'name' => 'Candidate1', 'party' => 'Party1' }, { 'name' => 'Candidate2', 'party' => 'Party2' }]
    end

    it 'returns candidate data for a successful API request' do
      stub_api_request(200, valid_json_body)
      expect(described_class.get_top_20_candidates('2020', 'pac-total')).to eq(expected_results)
    end

    it 'returns nil for a failed API request' do
      stub_api_request(500, 'Internal Server Error')
      expect(described_class.get_top_20_candidates('2020', 'pac-total')).to be_nil
    end

    def stub_api_request(status, body)
      cycle = '2020'
      category = 'pac-total'
      stub_request(:get, "https://api.propublica.org/campaign-finance/v1/#{cycle}/candidates/leaders/#{category}.json")
        .with(
          headers: {
            'Accept'          => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'      => 'Ruby'
          }
        )
        .to_return(status: status, body: body, headers: {})
    end
  end
end
