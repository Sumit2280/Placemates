class UserApplicationsController < ApplicationController

  def index
    render json: UserApplication.all
  end

  def create
    @user_application=UserApplication.create(create_params)
    if @user_application.valid?
      @opportunity=Opportunity.find(create_params[:opportunity_id])
      @opportunity.no_of_applications+=1
      @opportunity.save!
      render json: @user_application
    else
      render json: "something went wrong"
    end
  end

  def update
    id = params[:id]
    @user_application=UserApplication.find(id)
    @user_application.update(update_params)
    if @user_application.valid?
      render json: @user_application
    else
      render json: 'something went wrong'
    end
  end

  def destroy
    id= params[:id]
    @user_application=UserApplication.find(id)
    @opportunity=Opportunity.find(@user_application.opportunity_id)
    @opportunity.no_of_applications-=1
    @opportunity.save!
    @user_application.delete
    render json: 'success'
  end


  private
  def create_params
    params.require(:user_application).permit(:user_id, :opportunity_id, :status)
  end

  def update_params
    params.require(:user_application).permit(:status)
  end

end
