# frozen_string_literal: true

require 'rails_helper'
RSpec.describe NewsItemsController, type: :controller do
  let!(:representative) { Representative.create(name: 'John Doe', ocdid: 'ocdid_123', title: 'Mayor') }
  let!(:news_item) { representative.news_items.create(title: 'News Title', link: 'https://example.com') }

  describe 'GET #index' do
    it 'assigns @news_items' do
      get :index, params: { representative_id: representative.id }
      expect(assigns(:news_items)).to eq([news_item])
    end
  end

  describe 'GET #show' do
    it 'assigns @news_item' do
      get :show, params: { representative_id: representative.id, id: news_item.id }
      expect(assigns(:news_item)).to eq(news_item)
    end
  end

  describe 'GET #index with nonexistent representative' do
    it 'handles non-existing representative gracefully' do
      expect do
        get :index, params: { representative_id: 'nonexistent' }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'GET #show with nonexistent news item' do
    it 'handles non-existing news item gracefully' do
      expect do
        get :show, params: { representative_id: representative.id, id: 'nonexistent' }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
