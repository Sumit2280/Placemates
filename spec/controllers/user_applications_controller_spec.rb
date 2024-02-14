require 'rails_helper'
require 'auth_helper'

RSpec.describe UserApplicationsController, type: :controller do
  
  let(:role) {FactoryBot.create(:role)}
  let!(:user) { FactoryBot.create(:user, role_id: role.id) }
  let(:token_new) { encode(user_id: user.id)}
  let!(:token) { "Bearer #{token_new}"  }
  let!(:opportunity) {FactoryBot.create(:opportunity, company_id: 4)}

  before do 
    request.headers["Authorization"]=token
  end

  describe "GET #index" do
    it 'got application based on opportunity id' do

      get :index, params: {
        opportunity_id: 4
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'got application based on user id and status'  do

      get :index, params: {
        user_id: 1,
        status: "applied"
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'got application based on user id' do

      get :index, params: {
        user_id: 1
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'parameters not present' do

      get :index, params: {
        # user_id: 1
      }
      expect(response).to have_http_status(:bad_request)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe "POST #create" do
    it 'created successfully' do

      post :create, params: {
        opportunity_id: 4,
        user_id: user.id,
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'can not apply' do

      post :create, params: {
        opportunity_id: 2,
        user_id: user.id
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe "DELETE #destroy" do
    it 'deleted successfully' do

      delete :destroy, params: {
        id: 7,
        opportunity_id: 5
      }
      expect(response).to have_http_status(:ok)
    end
  end


end
