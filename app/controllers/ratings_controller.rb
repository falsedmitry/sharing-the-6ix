class RatingsController < ApplicationController

  def create
    @review = Review.find(params[:review][:review_id])
    @rating = Rating.new(review: @review)
    @rating.save
  end

  def update
    @rating = Rating.find(params[:id])

    if @rating.update_attributes(score: params[:score])
      respond_to do |format|
        format.js
      end
    end
  end

end
