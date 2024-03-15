class CompaniesController < ApplicationController
  
  def index
    if params[:name].present?
      company=Company.where(name: params[:name])
      print(company)
    else
      parameter_missing
    end
  end

  def create
    @company=Company.create(create_params)
    if @company.valid?
      render json: @company
    else
      render json: {error: I18n.t('errors.default')}, status: :unprocessable_entity
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
