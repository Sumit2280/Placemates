class TestimonialsController < ApplicationController
  def index
    render json: Testimonial.all
  end

  # def create

  # end

end
