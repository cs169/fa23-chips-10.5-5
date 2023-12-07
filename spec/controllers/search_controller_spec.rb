# frozen_string_literal: true

# spec/controllers/search_controller_spec.rb
require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #search' do
    let(:address) { '123 Main St' }
    let(:fake_service) { instance_double(Google::Apis::CivicinfoV2::CivicInfoService) }
    let(:fake_result) { instance_double(Google::Apis::CivicinfoV2::RepresentativeInfoResponse) }
    let(:representatives) { [instance_double(Representative)] }

    before do
      allow(Google::Apis::CivicinfoV2::CivicInfoService).to receive(:new).and_return(fake_service)
      allow(fake_service).to receive(:key=)
      allow(fake_service).to receive(:representative_info_by_address).with(address: address).and_return(fake_result)
      allow(Representative).to receive(:civic_api_to_representative_params).with(fake_result).and_return(representatives)
    end

    it 'fetches representatives for the given address' do
      get :search, params: { address: address }
      expect(assigns(:representatives)).to eq(representatives)
      expect(response).to render_template('representatives/search')
    end
  end
end
