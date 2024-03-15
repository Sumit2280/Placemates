class StudentPlacementsController < ApplicationController

  def index
    if params[:company_id].present?
      @student_placements=StudentPlacement.where(company_id: params[:company_id])
      print(@student_placements)
    else
      parameter_missing
    end
  end

  def create
    debugger
    @student_placement=StudentPlacement.create(create_params)
    @student_placement.company_id=params[:company_id]

    @user=User.find_by(email: params[:email])
    @user.update_attribute!(:placed, true)
    @user.save!

    @user_application=UserApplication.find_by(user_id: @user.id)
    @user_application.status="selected"
    @user_application.save

    @student_placement.user_id=@user.id
    @student_placement.save!

    if @student_placement.valid?
      render json: @student_placement
    else
      render json: {error: I18n.t('errors.default')}, status: :unprocessable_entity
    end

  end
  
  def show
    id=params[:id]
    @student_placement=StudentPlacement.find(id) 
    render json: @student_placement
  end

  private
  
  def create_params
    params.require(:student_placement).permit(:designation, :package, :requirements)
  end

end
