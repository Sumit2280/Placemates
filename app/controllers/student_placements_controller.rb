class StudentPlacementsController < ApplicationController

  def index
    render json: StudentPlacement.all
  end

  def create
    @student_placement=StudentPlacement.create(create_params)
    @company=Company.find_by(name: params[:name])
    @student_placement.company_id=@company.id
    @user=User.find_by(email: params[:email])
    @student_placement.user_id=@user.id
    @student_placement.save!
    if @student_placement.valid?
      render json: @student_placement
    else
      render json: "Something went wrong"
    end
  end
  
  def show
    id=params[:id]
    @student_placement=StudentPlacement.find(id) 
    render json: @student_placement
  end

  def create_params
    params.require(:student_placement).permit(:designation, :package, :requirements)
  end

end
