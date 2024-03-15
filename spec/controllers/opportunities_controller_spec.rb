require 'rails_helper'
require 'auth_helper'

RSpec.describe OpportunitiesController, type: :controller do

  let (:role) {FactoryBot.create(:role)}
  let! (:user) { FactoryBot.create(:user, role_id: role.id) }
  let (:token_new) { encode(user_id: user.id)}
  let! (:token) { "Bearer #{token_new}"  }
  let! (:company) {FactoryBot.create(:company)}

  before do
    request.headers["Authorization"]=token
  end

  describe "GET #index" do
    it 'Got opportunities with company_id' do
      request.headers["Authorization"]=token
      get :index, params: {
        company_id: 4
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'Got opportunities with status' do
      request.headers["Authorization"]=token
      get :index, params: {
        status: "ongoing"
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'did not pass any parameter' do
      request.headers["Authorization"]=token
      get :index, params: {

      }
      expect(response).to have_http_status(:bad_request)
      # expect(response.content_type).to eq('application/json; charset=utf-8')
    end

  end

  describe "POST #create" do
    it 'Created successfully' do
      # byebug
      request.headers["Authorization"]=token
      post :create, params: {
        company_id: company.id,
         opportunity: {
          status: "applicable",
          no_of_applications: 0,
          designation: "developer",
          skillset: "java",
          package: 11.22,
          start_date: "21-02-24",
          end_date: "24-02-24"
        }
      }
      # byebug
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'company_id required to create the company' do
      request.headers["Authorization"]=token
      post :create, params: {
         opportunity: {
          # company_id: company.id
          status: "applicable",
          no_of_applications: 0,
          designation: "developer",
          skillset: "java",
          package: 11.22,
          start_date: "21-02-24",
          end_date: "24-02-24"
        }
      }
    expect(response).to have_http_status(:unprocessable_entity)
    # expect(response.body).to eq("error": I18n.t('errors.default'))
    end
  end

  describe "PUT #update" do
    it 'Updated successfully' do
      # byebug
      request.headers["Authorization"]=token
      put :update, params: {
        id: 4,
        opportunity: {
          status: "applicable",
          no_of_applications: 0,
          designation: "developer",
          skillset: "java",
          package: 11.22,
          start_date: "21-02-24",
          end_date: "24-02-24"
        }
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'opportunity not found' do
      request.headers["Authorization"]=token
      put :update, params: {
        id:1000,
        opportunity: {
          status: "applicable",
          no_of_applications: 0,
          designation: "developer",
          skillset: "java",
          package: 11.22,
          start_date: "21-02-24",
          end_date: "24-02-24"
        }
      }
      expect(response).to have_http_status(:not_found)
      # expect(response.body).to eq(I18n.t('errors.default'))
    end
  end

  # describe "DELETE #destroy" do
  #   it 'deleted successfully' do
  #     request.headers["Authorization"]=token
  #     delete :destroy, params: {
  #       id: 2
  #     }
  #     expect(response).to have_http_status(:ok)
  #     expect(response.body).to eq(I18n.t('success.delete'))
  #   end
  # end

  describe "POST #close_opportunity" do
    it 'Opportunity closed successfully' do
      post :close_opportunity, params: {
        id: 4
      }
      expect(response).to have_http_status(:ok)
    end
  end
    
end