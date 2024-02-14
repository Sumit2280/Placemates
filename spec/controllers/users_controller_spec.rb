require 'rails_helper'
require 'auth_helper'

RSpec.describe UsersController, type: :controller do
  # debugger
  let(:role) {FactoryBot.create(:role)}
  let!(:user) { FactoryBot.create(:user, role_id: role.id) }
  let(:token_new) { encode(user_id: user.id)}
  let!(:token) { "Bearer #{token_new}"  }


  describe 'GET #index' do
    it 'renders JSON with first name' do
      request.headers["Authorization"]=token
      # user_count = User.count
      get :index, params: {first_name: "Pok"}
      # user_count+1 = User.count
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'renders JSON with last name' do
      request.headers["Authorization"]=token
      # user_count = User.count
      get :index, params: {last_name: "Hills"}
      # user_count+1 = User.count
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'renders JSON with placed users' do
      request.headers["Authorization"]=token
      get :index, params: {placed: false}
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'if parameters are not present' do 
      request.headers["Authorization"]=token
      get :index, params: {}
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'POST #create' do
    it "Create user" do
      post :create, params: {
        user: {
        role_id: 3,
        email: "zxcvb@gmail.com",
        password: "123",
        first_name: "sumit",
        last_name: "done",
        placed: true,
        batch: "2024",
        branch: "comp",
        linkedin: "sumitdone"
        }
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'POST #login' do
    it "log in user" do
      post :login, params: {
        email: "sumit@gmail.com",
        password: "123"
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it "log in with incorrect email or password" do
      post :login, params: {
        email: "sumit@gmail.com",
        password: "12"
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'PUT #update' do
    it "update user" do
      request.headers["Authorization"]=token
      put :update, params: {
        id: 12,
        user: {
          linkedin: Faker::Internet.url
        }
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it "update user" do
      request.headers["Authorization"]=token
      put :update, params: {
        id: 12,
        user: {
          # linkedin: Faker::Internet.url
        }
      }
      expect(response).to have_http_status(:bad_request)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

  end

  describe 'GET #show' do
    it "show user" do
      request.headers["Authorization"]=token
      get :show, params: {
        id: 12,
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it "show user" do
      request.headers["Authorization"]=token
      get :show, params: {
        id: 12234
      }
      expect(response).to have_http_status(:not_found)
      # expect(response.content_type).to eq('application/json; charset=utf-8')
    end

  end

  # describe 'DELETE #destroy' do
  #   it "delete user" do
  #     request.headers["Authorization"]=token
  #     delete :destroy, params: {
  #       id: 12,
  #     }
  #     expect(response).to have_http_status(:ok)
  #     expect(response.content_type).to eq('application/json; charset=utf-8')
  #   end

  #   it "delete user" do
  #     request.headers["Authorization"]=token
  #     delete :destroy, params: {
  #       id: 120,
  #     }
  #     expect(response).to have_http_status(:not_found)
  #   end
    
  # end

end
