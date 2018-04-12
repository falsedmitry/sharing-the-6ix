class ReviewsController < ApplicationController
  before_action :load_review, only: [:edit, :update, :destroy]
  before_action :load_tool

  def create
    @tool = Tool.find(params[:tool_id])
    @reviews = @tool.reviews.order(created_at: :desc)
    @review = Review.new(params.require(:review).permit(:comment, {images: []}))

    @review.tool_id = params[:tool_id]
    @review.user_id = current_user.id

    if params[:score].empty?
      @rating = Rating.new(review: @review, score: 0)
    else
      @rating = Rating.new(review: @review, score: params[:score])
    end

    if params[:review][:images] != []
      if @review.save
        @rating.save
        redirect_to tool_url(@tool)
      else
        puts @tool.errors.full_messages
        flash[:alert] = "Something went wrong."
        render "/tools/show.html.erb"
      end
    else
      flash[:alert] = "Please upload at least 1 photo"
      redirect_to tool_url(@tool)
    end
  end

  def edit
    @tool = @review.tool
    @rating = Rating.where(review: @review).first
  end

  def update
    @tool = Tool.find(params[:tool_id])
    @reviews = @tool.reviews.order(created_at: :desc)
    @rating = Rating.where(review: @review).first

    Review.update(@review.id, params.require(:review).permit(:comment, :rating, {images: []}))

    if @review.save
      redirect_to tool_url(@tool)
    else
      render "/tools/show.html.erb"
    end
  end

  def destroy
    @review.destroy
    flash[:notice] = "You have successfully deleted the comment!"
    redirect_to tool_url(@tool)
  end

  private
    def load_review
      @review = Review.find(params[:id])
    end

    def load_tool
      @tool = Tool.find(params[:tool_id])
    end
end
