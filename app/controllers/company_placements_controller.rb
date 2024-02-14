class CompanyPlacementsController < ApplicationController
 

  def index

    if params[:company_id].present?
      @company_placements=CompanyPlacement.where(company_id: params[:company_id])
      print(@company_placements)
    else
      parameter_missing
    end

  end

  def create
    # debugger
    @company_placement=CompanyPlacement.create(create_params)
    @company_placement.company_id=params[:company_id]
    @company_placement.save!
    if @company_placement.valid?
      render json: @company_placement
    else
      render json: I18n.t('errors.default'), status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:company_placement).permit(:applied, :selected, :year)
  end

end
