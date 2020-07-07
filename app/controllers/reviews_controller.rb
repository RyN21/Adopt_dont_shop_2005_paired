class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])
    review = @shelter.reviews.create(review_params)
    require "pry"; binding.pry
    redirect_to "/shelters/#{@shelter.id}"
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
#
#   def edit
#     @review = Review.find(params[:id])
#     @review.update(review_params)
#     redirect_to "/shelters/#{@review.shelter_id}"
#   end
#
# end
