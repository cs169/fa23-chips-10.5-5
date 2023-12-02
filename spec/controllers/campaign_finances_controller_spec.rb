# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CampaignFinancesController, type: :controller do
  describe 'search' do
    before do
      get :search
    end

    it 'assigns cycles options to valid values' do
      expect(assigns(:cycle_options)).to eq([2010, 2012, 2014, 2016, 2018, 2020])
    end

    it 'assigns category options to valid values' do
      expect(assigns(:category_options)).to match_array(
        %w[candidate-loan contribution-total debts-owed disbursements-total end-cash
           individual-total pac-total receipts-total refund-total]
      )
    end
  end

  describe 'show' do
    it 'assigns @representatives to lists of rank, name, and party' do
      allow(CampaignFinance).to receive(:get_top_20_candidates).and_return(
        [{ 'name' => 'Candidate1', 'party' => 'Party1' }, { 'name' => 'Candidate2', 'party' => 'Party2' }]
      )
      get :show, params: { cycle: '2020', category: 'pac-total' }
      expect(assigns(:representatives)).to eq([[1, 'Candidate1', 'Party1'], [2, 'Candidate2', 'Party2']])
    end

    it 'renders the show template' do
      allow(CampaignFinance).to receive(:get_top_20_candidates).and_return([])
      get :show, params: { cycle: '2020', category: 'pac-total' }
      expect(response).to render_template(:show)
    end
  end
end
