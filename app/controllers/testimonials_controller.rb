class TestimonialsController < ApplicationController
  
  def index
    render json: Testimonial.all
  end

  # def create


  # def create

  # end

end
