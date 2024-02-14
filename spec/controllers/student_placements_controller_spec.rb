require 'rails_helper'
require 'auth_helper'

RSpec.describe OpportunitiesController, type: :controller do
  
  let (:role) {FactoryBot.create(:role)}
  let! (:user) { FactoryBot.create(:user, role_id: role.id) }
  let (:token_new) { encode(user_id: user.id)}
  let! (:token) { "Bearer #{token_new}"  }
  let! (:company) {FactoryBot.create(:company)}

  describe "GET #index" do
    it 'found student wiht company_id' do
      request.headers["Authorization"]=token
      get :index, params: {
        company_id: 3
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'not found any student data' do
      request.headers["Authorization"]=token
      get :index, params: {
      }
      expect(response).to have_http_status(:bad_request)
    end
  end

  describe "Post #create" do
    it 'created successfully' do
      request.headers["Authorization"]=token
      post :create, params: {
        company_id: company.id,
        email: "michelle@kuphal.example",
        student_placement: {
          designation: "developer",
          package: 21.4,
          requirements: "mern stack"
        }
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  
end