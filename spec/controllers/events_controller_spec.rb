# spec/controllers/events_controller_spec.rb
require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:state) { instance_double(State, id: 1, symbol: 'NY', name: 'New York', fips_code: 'NY01', is_territory: false) }
  let(:county) { instance_double(County, id: 1, std_fips_code: '12345', state: state) }
  let(:event) { instance_double(Event, id: 1, name: 'Event Name', county: county) }
  let(:counties) { [county] } # Assuming this is how counties would be represented

  describe 'GET #index' do
    context 'without filters' do
      it 'assigns all events to @events' do
        allow(Event).to receive(:all).and_return([event])
        get :index
        expect(assigns(:events)).to eq([event])
      end
    end

    context 'when filtered by state' do
      let(:events) { [event] }

      before do
        allow(State).to receive(:find_by).with(symbol: 'NY').and_return(state)
        allow(state).to receive(:id).and_return(1)
        allow(state).to receive(:counties).and_return(counties) # Stubbing the counties method
        allow(Event).to receive(:where).with(county: counties).and_return(events)
      end

      it 'assigns filtered events to @events' do
        get :index, params: { 'filter-by': 'state-only', state: 'NY' }
        expect(assigns(:events)).to match_array(events)
      end
    end

    context 'when filtered by county' do
      let(:events) { [event] }

      before do
        allow(State).to receive(:find_by).with(symbol: 'NY').and_return(state)
        allow(County).to receive(:find_by).with(state_id: 1, fips_code: '12345').and_return(county)
        allow(Event).to receive(:where).with(county: county).and_return(events)
      end

      it 'assigns filtered events to @events' do
        get :index, params: { 'filter-by': 'county', state: 'NY', county: '12345' }
        expect(assigns(:events)).to match_array(events)
      end
    end
  end

  describe 'GET #show' do
    it 'assigns the requested event to @event' do
      allow(Event).to receive(:find).with('1').and_return(event)
      get :show, params: { id: '1' }
      expect(assigns(:event)).to eq(event)
    end
  end
end
