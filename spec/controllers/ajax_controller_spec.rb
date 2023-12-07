# frozen_string_literal: true

# spec/controllers/ajax_controller_spec.rb
require 'rails_helper'

RSpec.describe AjaxController, type: :controller do
  let(:state) { instance_double(State, symbol: 'NY', name: 'New York', fips_code: 'NY01', is_territory: false) }
  let(:counties) { [instance_double(County, id: 1, std_fips_code: '12345', name: 'County1', state: state)] }

  describe 'GET #counties' do
    context 'when state is found' do
      before do
        allow(State).to receive(:find_by).with(symbol: 'NY').and_return(state)
        allow(state).to receive(:counties).and_return(counties)
      end

      it 'returns counties as JSON' do
        get :counties, params: { state_symbol: 'NY' }, format: :json
        expect(response.content_type).to eq('application/json')
        expect(response.body).to eq(counties.to_json)
      end
    end

    context 'when state is not found' do
      before do
        allow(State).to receive(:find_by).with(symbol: 'ZZ').and_return(nil)
      end

      it 'returns an empty response' do
        get :counties, params: { state_symbol: 'ZZ' }, format: :json
        expect(response.body).to eq('[]') # Expecting an empty array as JSON
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
