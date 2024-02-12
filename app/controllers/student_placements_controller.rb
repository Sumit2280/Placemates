class StudentPlacementsController < ApplicationController

  def index

    if params[:company_id].present?
      @student_placements=StudentPlacement.where(company_id: params[:company_id])
      print(@student_placements)
    else
      render json: StudentPlacement.all
    end

  end

  def create
    # debugger
    @student_placement=StudentPlacement.create(create_params)
    @student_placement.company_id=params[:company_id]

    @user=User.find_by(email: params[:email])
    @user.placed=true
    @user.save

    @user_application=UserApplication.find_by(user_id: @user.id)
    @user_application.status="selected"
    @user_application.save

    @student_placement.user_id=@user.id
    @student_placement.save!

    if @student_placement.valid?
      render json: @student_placement
    else
      render json: I18n.t('errors.default')
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

  def print(student_placements)

    if student_placements.empty?
      render json: I18n.t('errors.empty')
    else
      render json: student_placements
    end

  end

end
