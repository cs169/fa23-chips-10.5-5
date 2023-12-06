# frozen_string_literal: true

require 'rails_helper'
RSpec.describe MapController, type: :controller do
  let(:state) { instance_double(State, symbol: 'NY', name: 'New York', fips_code: 'NY01', is_territory: false) }
  let(:county) { instance_double(County, std_fips_code: '12345') }

  before do
    allow(State).to receive(:create).and_return(state)
    allow(County).to receive(:create).and_return(county)
  end

  describe 'GET #state' do
    context 'when state does not exist' do
      it 'redirects to root path with an alert' do
        get :state, params: { state_symbol: 'invalid_state' }
        expect(response).to redirect_to(root_path)
        expect(flash[:alert]).to eq("State 'INVALID_STATE' not found.")
      end
    end
  end

  describe 'GET #index' do
    let(:state_with_fips_code) { instance_double(State, std_fips_code: 'NY01') }

    before do
      allow(State).to receive(:all).and_return([state_with_fips_code])
    end

    it 'assigns all states to @states' do
      get :index
      expect(State).to have_received(:all)
      expect(assigns(:states)).to eq([state_with_fips_code])
    end

    it 'indexes states by FIPS code' do
      get :index
      expect(assigns(:states_by_fips_code)).to eq({ 'NY01' => state_with_fips_code })
    end
  end
end
