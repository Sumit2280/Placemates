class ApplicationController < ActionController::API
  # protect_from_forgery
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  # rescue_from head :no_content

  before_action :authorized 
  load_and_authorize_resource 

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials[:secret_key_base]) 
  end

  def decoded_token
    # byebug
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
      render json: { message: I18n.t('errors.log_in') }, status: :unauthorized unless logged_in?
  end

  private

  def record_not_found
    render json: { error: I18n.t('errors.not_found') }, status: :not_found
  end

  def parameter_missing
    render json: { error: I18n.t('errors.bad_request') }, status: :bad_request
  end

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: I18n.t('errors.unauthorized') },  status: :unauthorized
  end

  def record_invalid(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def print(data)

    if data.empty?
      record_not_found
    else
      render json: data
    end
  end

end
