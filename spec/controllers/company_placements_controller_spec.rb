require 'rails_helper'
require 'auth_helper'

RSpec.describe CompanyPlacementsController, type: :controller do

  let (:role) {FactoryBot.create(:role)}
  let! (:user) { FactoryBot.create(:user, role_id: role.id) }
  let (:token_new) { encode(user_id: user.id)}
  let! (:token) { "Bearer #{token_new}"  }
  let! (:company) {FactoryBot.create(:company)}

  describe "GET #index" do
    it 'got the company with id' do
      request.headers["Authorization"]=token
      get :index, params: {
        company_id: 2
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'parameter missing in index' do
      request.headers["Authorization"]=token
      get :index, params: {
        
      }
      expect(response).to have_http_status(:bad_request)
      # expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe "POST #create" do
    it 'created successfully' do
    # byebug
      request.headers["Authorization"]=token
      post :create, params: {
        company_id: company.id,
        company_placement: {
          year: "2020",
          applied: Faker::Number.between(from: 1, to: 1000),
          selected: Faker::Number.between(from: 1, to: 100)
        }
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
 
    end

    it 'company_id required' do
      request.headers["Authorization"]=token
      post :create, params: {
        # company_id: Faker::Number.between(from: 1, to: 5),
        company_placement: {
          year: "2020",
          applied: Faker::Number.between(from: 1, to: 1000),
          selected: Faker::Number.between(from: 1, to: 100)
        }
      }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end


  
end