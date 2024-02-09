class ApplicationController < ActionController::API
  # protect_from_forgery
  before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials[:secret_key_base]) 
  end

  def decoded_token
    # debugger
    header = request.headers['Authorization']
    if header
      token = header.split(" ")[1]
      begin
          JWT.decode(token, Rails.application.credentials[:secret_key_base])
      rescue JWT::DecodeError
          nil
      end
    end
  end

  def current_user
    # debugger
    if decoded_token
        user_id = decoded_token[0]['user_id']
        @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
      !!current_user
  end

  def authorized
      render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end

end
