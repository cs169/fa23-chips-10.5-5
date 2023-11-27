# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController, type: :controller do
  describe 'show individual reps profile page' do
    describe 'rep values are missing' do
      before do
        bad_rep = instance_double(
          Representative,
          id:      1,
          name:    nil,
          title:   nil,
          ocdid:   nil,
          party:   nil,
          address: nil
        )
        allow(Representative).to receive(:find).with('1').and_return(bad_rep)
        get :show, params: { id: 1 }
      end

      it 'bad name' do
        expect(assigns(:rep_name)).to eq('Name not found')
      end

      it 'bad ocdid' do
        expect(assigns(:rep_ocdid)).to eq('OC DID not found')
      end

      it 'bad title' do
        expect(assigns(:rep_title)).to eq('Title not found')
      end

      it 'bad party' do
        expect(assigns(:rep_party)).to eq('Party not found')
      end

      it 'bad address' do
        expect(assigns(:rep_address)).to eq('Address not found')
      end
    end

    describe 'rep values are present' do
      before do
        good_rep = instance_double(
          Representative,
          id:      2,
          name:    'Joe Biden',
          title:   'potus',
          ocdid:   'ocd-division/country:us',
          party:   'democrat',
          address: [{
            'line1' => '1600 Pennsylvania Avenue Northwest',
            'city'  => 'Washington',
            'state' => 'DC',
            'zip'   => '20500'
          }]
        )
        allow(Representative).to receive(:find).with('2').and_return(good_rep)
        get :show, params: { id: 2 }
      end

      it 'good name' do
        expect(assigns(:rep_name)).to eq('Joe Biden')
      end

      it 'good ocdid' do
        expect(assigns(:rep_title)).to eq('potus')
      end

      it 'good title' do
        expect(assigns(:rep_ocdid)).to eq('ocd-division/country:us')
      end

      it 'good party' do
        expect(assigns(:rep_party)).to eq('democrat')
      end

      it 'good address' do
        expect(assigns(:rep_address)).to eq('1600 Pennsylvania Avenue Northwest Washington DC 20500')
      end
    end
  end
end
