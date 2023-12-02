# frozen_string_literal: true

class CampaignFinancesController < ApplicationController
  def search
    @cycle_options = [2010, 2012, 2014, 2016, 2018, 2020]
    @category_options = %w[
      candidate-loan
      contribution-total
      debts-owed
      disbursements-total
      end-cash
      individual-total
      pac-total
      receipts-total
      refund-total
    ]
  end

  def show
    @representatives = []
    CampaignFinance.get_top_20_candidates(params[:cycle], params[:category]).each_with_index do |rep, index|
      @representatives.push([index, rep['name'], rep['party']])
    end
  end
end
