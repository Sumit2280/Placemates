class OpportunitiesController < ApplicationController

  def index 

    if params[:company_id].present?
      @opportunities=Opportunity.where(company_id: params[:company_id])
      print(@opportunities)

    elsif params[:status].present?
      @opportunities=Opportunity.where(status: params[:status])
      print(@opportunities)

    else
      render json: Opportunity.all
    end

  end

  def create
    @opportunity=Opportunity.create(create_params)
    if @opportunity.valid?
      render json: @opportunity
    else
      render json: I18n.t('errors.default')
    end
  end

  def update
    id = params[:id]
    @opportunity=Opportunity.find(id)
    @opportunity.update(update_params)
    if @opportunity.valid?
      render json: @opportunity
    else
      render json: I18n.t('errors.default')
    end
  end

  def close_opportunity
    id=params[:id]
    @opportunity=Opportunity.find(id)
    @opportunity.status="closed"
    @opportunity.save
    UserApplication.where(opportunity_id: id).find_each do |user_application|
      user_application.status='not selected'
      user_application.save
    end
  end



  # def show
  #   if params[:company_id].present?
  #     @opportunities=Opportunity.where(compnay_id: :params[:company_id])
  #     render json: @opportunities
  #   else
  #     render json: I18n.t('errors.empty')
  #   end
  # end

  def destroy
    id = params[:id]
    @opportunity=Opportunity.find(id)
    @opportunity.delete
    render json: I18n.t('success.delete')
  end


  private

  def create_params
    params.permit(:company_id, :status, :no_of_applications, :designation, :skillset, :package, :start_date, :end_date)
  end

  def update_params
    params.require(:opportunity).permit(:status, :no_of_applications, :designation, :skillset, :package, :start_date, :end_date)
  end

  def print (opportunities)
    if opportunities.empty?
      render json: I18n.t('errors.empty')
    else
      render json: opportunities
    end
  end

end

