class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :login]
  
  def index
    @users=User.all
    render json: @users
  end

  def create
    @user=User.create!(create_params)
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

  def update
    id = params[:id]
    @user = User.find(id)
    @user.update(update_params)
    render json: @user
  end

  def show
    id = params[:id]
    @user = User.find(id)
    render json: @user
  end

  def destroy
    id= params[:id]
    @user= User.find(id)
    @user.delete
    json render: "Successfully Deleted"
  end
  
  private
  def update_params
    params.require(:user).permit(:linkedin)
  end
  
  def create_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :placed, :batch, :branch, :linkedin, :role_id)
  end

end
