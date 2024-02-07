class BlogsController < ApplicationController
  
  def index
    @blogs=Blog.all
    render json: @blogs
  end

  def create 
    begin
      @blog=Blog.create(create_params)
      if @blog.valid?
        render json: @blog
      else
        render json: {error: "Something went wrong"}
      end
    rescue ActiveRecord::RecordInvalid
      render json: {error: "user_id not present"}
    end
  end

  private

  def create_params
    params.require(:blog).permit(:title, :description, :user_id)
  end

end
