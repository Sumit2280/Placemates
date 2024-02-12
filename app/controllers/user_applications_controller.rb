class UserApplicationsController < ApplicationController

  def index
    
    if params[:opportunity_id].present?
      @user_applications=UserApplication.where(opportunity_id: params[:opportunity_id])
      print(@user_applications)
      
    elsif params[:user_id].present?

      if params[:status].present?
        @user_applications=UserApplication.where(status: params[:status])
        print(@user_applications)

      else
        @user_applications=UserApplication.where(user_id: params[:user_id])
      end

    else
      render json: UserApplication.all
    end

  end

  def create
    # debugger
    if Opporutnity.find(params[:opportunity_id]).status="applicable" 
      if User.find(params[:user_id]).placed=false
        @user_application=UserApplication.create(create_params)
        if @user_application.valid?
          @user_application.status="applied"
          @user_application.save
          @opportunity=Opportunity.find(create_params[:opportunity_id])
          @opportunity.no_of_applications+=1
          @opportunity.save!
          render json: @user_application
        else
          render json: @user_application.errors.full_message
          # render json: I18n.t('errors.default')
        end
      else
        render json: "Can't apply"

    else
      render json: "Application for Opportunity is not open"
    end

  end

  def update
    id = params[:id]
    @user_application=UserApplication.find(id)
    @user_application.update(update_params)
    if @user_application.valid?
      render json: @user_application
    else
      render json: I18n.t('errors.default')
    end
  end

  def destroy
    # debugger
    id= params[:id]
    @user_application=UserApplication.find(id)
    @opportunity=Opportunity.find(params[:opportunity_id])
    @opportunity.no_of_applications-=1
    @opportunity.save!
    @user_application.delete
    render json: I18n.t('success.delete')
  end


  private
  def create_params
    params.permit(:user_id, :opportunity_id)
  end

  def update_params
    params.require(:user_application).permit(:status)
  end

  def print(user_application)
    if user_application.empty?
      render json: I18n.t('errors.empty')
    else
      render json: user_application
    end
  end

end
