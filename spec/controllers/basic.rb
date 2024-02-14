describe "GET #index" do
   byebug
    it 'abcd' do
      byebug
    end

    it 'got application based on opportunity id' do
      request.headers["Authorization"]=token
      byebug
      get :index, params: {
        opportunity_id: 4
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'got application based on user id' do
      request.headers["Authorization"]=token
      get :index, params: {
        user_id: 1,
        status: "applied"
      }
    end
  end

  describe "POST #create" do
    it 'created successfully' do
      request.headers["Authorization"]=token
      post :create, params: {
        opportunity_id: 4,
        user_id: user.id,
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'can not apply' do
      request.headers["Authorization"]=token
      post :create, params: {
        opportunity_id: 2,
        user_id: user.id
      }
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end
