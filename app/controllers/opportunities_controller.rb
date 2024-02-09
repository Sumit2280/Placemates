class OpportunitiesController < ApplicationController

  def index
    render json: Opportunity.all
  end

  def create
    @opportunity=Opportunity.create(create_params)
    if @opportunity.valid?
      render json: @opportunity
    else
      render json: 'something went wrong'
    end
  end

  def update
    id = params[:id]
    @opportunity=Opportunity.find(id)
    @opportunity.update(update_params)
    if @opportunity.valid?
      render json: @opportunity
    else
      render json: 'something went wrong'
    end
  end

  def destroy
    id= params[:id]
    @opportunity=Opportunity.find(id)
    @opportunity.delete
    render json: 'success'
  end


  private

  def create_params
    params.require(:opportunity).permit(:company_id, :status, :no_of_applications, :designation, :skillset, :package, :start_date, :end_date)
  end

  def update_params
    params.require(:opportunity).permit(:status, :no_of_applications, :designation, :skillset, :package, :start_date, :end_date)
  end

end

