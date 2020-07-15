class ReviewsController < ApplicationController
  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.find(params[:id])

    @review = shelter.reviews.new(review_params)
    if @review.save
      redirect_to "/shelters/#{shelter.id}"
    else @review.errors.any?
      flash.alert = @review.errors.full_messages.each do |msg|
        msg
      end
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    if @review.save
      redirect_to "/shelters/#{@review.shelter_id}"
    else @review.errors.any?
      flash.alert = @review.errors.full_messages.each do |msg|
        msg
      end
      redirect_to "/reviews/#{@review.id}/edit"
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to "/shelters/#{review.shelter_id}"


  end

  private
  def review_params
    params.permit(:title, :rating, :content, :image)
  end
end
