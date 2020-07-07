class ReviewController < ApplicationController
  def index
    @reviews = Review.all
  end
end
