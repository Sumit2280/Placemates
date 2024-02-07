class UsersController < ApplicationController
  def index
    @users=User.all
    render json: @users
  end

  def create
    @user=User.create(create_params)
    if @user.valid?
      @token = encode_token(@user.id)
      render json: {user:@user, token:@token}
    else
      render json: {error: "Invalid email or Password"}
    end
  end

  def login
    @user = User.find_by(email: params[:email])
    if
      @user && @user.authenticate(params[:password])      
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid email or password"}
    end
  end

  def update_info
    @user = User.find_by(email: params[:email])
    if @user
      @user.update(update_params)
      render json: @user
    else 
      render json: {error: "not a valid user"}
    end
  end

  def search
    begin
      @user = User.find_by(email: params[:email])
      render json: @user
    rescue ActiveRecord::RecordNotFound
      render json: {error: "Not a valid user"}
    end
  end

  def destroy
    # debugger
    begin
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        @user.delete
        render json: "Success"
      else
        render json: "invalid username of password"
      end
    rescue ActiveRecord::RecordNotFound
      render json: {error: "not a valid user"}
    end
  end
  
  private

  def create_params
    params.require(:user).permit(:email, :password)
  end
  
  def update_params
    params.require(:user).permit(:first_name, :last_name, :placed, :batch, :branch)
  end

end
