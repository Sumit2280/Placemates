class UserApplicationsController < ApplicationController

  def index
    
    if params[:opportunity_id].present?
      @user_applications=UserApplication.where(opportunity_id: params[:opportunity_id])
      print(@user_applications)
      
    elsif params[:user_id].present?
      if params[:status].present?
        @user_applications=UserApplication.where(status: params[:status])
      else
        @user_applications=UserApplication.where(user_id: params[:user_id])
      end
      print(@user_applications)

    else
      parameter_missing
    end

  end

  def create
    # debugger
    if Opportunity.find(params[:opportunity_id]).status=="applicable" 
      if User.find(params[:user_id]).placed==false
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
        render json: {message: I18n.t('application.placed')}, status: :ok
      end
    else
      render json: {message:  I18n.t('application.closed') }, status: :ok
    end

  end

  def destroy
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

  # def update_params
  #   params.require(:user_application).permit(:status)
  # end

end
