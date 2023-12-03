# frozen_string_literal: true

require 'rails_helper'
RSpec.describe LoginController, type: :controller do
  let(:user_info) do
    {
      'provider' => 'google_oauth2',
      'uid'      => '123',
      'info'     => {
        'first_name' => 'John',
        'last_name'  => 'Doe',
        'email'      => 'john@example.com'
      }
    }
  end

  describe 'GET #login' do
    it 'renders the login template' do
      get :login
      expect(response).to render_template(:login)
    end
  end

  describe 'GET #google_oauth2 & #github' do
    before do
      request.env['omniauth.auth'] = user_info
    end

    it 'redirects to create_google_user' do
      get :google_oauth2
      expect(response).to redirect_to(root_url)
    end

    it 'redirects to create_github_user' do
      get :github
      expect(response).to redirect_to(root_url)
    end
  end

  describe 'GET #logout' do
    it 'logs out the user' do
      get :logout
      expect(session[:current_user_id]).to be_nil
      expect(response).to redirect_to(root_path)
    end
  end

  # Test private methods by making them public temporarily
  describe 'private methods' do
    before do
      @controller = described_class.new
      @controller.request = ActionDispatch::TestRequest.create
      @controller.request.env['HTTP_REFERER'] = 'http://test.host'
    end

    describe '#find_or_create_user' do
      it 'finds or creates a user' do
        allow(@controller).to receive(:find_or_create_user).and_call_original
        user = @controller.send(:find_or_create_user, user_info, :create_google_user)
        expect(user).to be_instance_of(User)
      end
    end
  end
end
