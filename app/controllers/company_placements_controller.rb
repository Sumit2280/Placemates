class CompanyPlacementsController < ApplicationController
  def index
    render json: CompanyPlacement.all
  end

  def create
    debugger
    @company_placement=CompanyPlacement.create(create_params)
    @company=Company.find_by(name: params[:name])
    @company_placement.company_id=@company.id
    @company_placement.save!
    if @company_placement.valid?
      render json: @company_placement
    else
      render json: "something went wrong"
    end
  end

  def create_params
    params.require(:company_placement).permit(:applied, :selected, :year)
  end


end
