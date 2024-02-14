require 'rails_helper'
require 'auth_helper'

RSpec.describe CompaniesController, type: :controller do

  let(:role) {FactoryBot.create(:role)}
  let!(:user) { FactoryBot.create(:user, role_id: role.id) }
  let (:token_new) { encode(user_id: user.id)}
  let! (:token) { "Bearer #{token_new}"  }

  describe "POST #create" do
    it "Create company" do
      # byebug
      request.headers["Authorization"]=token
      post :create, params: {
        company: {
          name: Faker::Company.name,
          information: Faker::Lorem.sentence,
          website: Faker::Internet.url
        }
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it "Create company" do
      # byebug
      request.headers["Authorization"]=token
      post :create, params: {
          name: Faker::Company.name,
          information: Faker::Lorem.sentence,
          website: Faker::Internet.url
      }
      expect(response).to have_http_status(:bad_request)
      # expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe "GET #index" do
    it "get company with name" do
      request.headers["Authorization"]=token
      get :index, params: {
        name: "Predovic and Sons"
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it "company not found with name" do
      request.headers["Authorization"]=token
      get :index, params: {
        name: "josh"
      }
      expect(response).to have_http_status(:not_found)
      # expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe "GET #show" do
    it "found company with id" do
      request.headers["Authorization"]=token
      get :show, params: {
        id: 4
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it "company not found" do
      request.headers["Authorization"]=token
      get :show, params: {
        id: 112
      }
      expect(response).to have_http_status(:not_found)
      # expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe "PUT #update" do
    it "Update company" do
      # byebug
      request.headers["Authorization"]=token
      put :update, params: {
        id: 2,
        company: {
          name: Faker::Company.name,
          information: Faker::Lorem.sentence,
          website: Faker::Internet.url
        }
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it "Update company" do
      # byebug
      request.headers["Authorization"]=token
      put :update, params: {
        id: 3,
        name: Faker::Company.name,
        information: Faker::Lorem.sentence,
        website: Faker::Internet.url
      }
      expect(response).to have_http_status(:bad_request)
      # expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end
  
end