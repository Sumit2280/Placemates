class CompaniesController < ApplicationController

  def index
    render json: Company.all
  end

  def create
    @company=Company.create(create_params)
    if @company.valid?
      render json: @company
    else
      render json: "Something went Wrong"
    end
  end

  def show
    id=params[:id]
    @company=Company.find(id)
    render json: @company
  end

  def update
    id=params[:id]
    @company=Company.find(id)
    @company.update(update_params)
    render json: @company
  end

  private

  def create_params
    params.require(:company).permit(:name, :information, :website)
  end

  def update_params
    params.require(:company).permit(:name, :information, :website)
  end

end
