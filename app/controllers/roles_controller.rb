class RolesController < ApplicationController
  def index
    render json: Role.all
  end
  
end
