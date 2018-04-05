class ReviewsController < ApplicationController
  before_action :load_review, only: [:edit, :update, :destroy]

  def create
    @review = Review.new

    @review.comment = params[:review][:comment]
    @review.rating = params[:review][:rating]
    @review.tool_id = params[:tool_id]
    @review.user_id = current_user.id

    if @review.save
      upload_pictures
      redirect_to tool_url(params[:tool_id])
    else
      flash[:alert] = "Comment cannot be empty!"
      render tool_url(params[:tool_id])
    end
  end

  def edit
    @tool = @review.tool
  end

  def update
    @review.comment = params[:review][:comment]
    @review.rating = params[:review][:rating]

    if @review.save
      redirect_to tool_url(params[:tool_id])
    else
      flash[:alert] = "Comment cannot be empty!"
      render tool_url(params[:tool_id])
    end
  end

  def destroy
    @review.destroy
    flash[:notice] = "You have successfully deleted the comment!"
    redirect_to tool_url(params[:tool_id])
  end

  private
    def load_review
      @review = Review.find(params[:id])
    end

    def upload_pictures
      unless params[:review][:picture] == nil
        uploaded_ios = params[:review][:picture]
        uploaded_ios.each do |uploaded_io|
          File.open(Rails.root.join('public', 'images', uploaded_io.original_filename), 'wb') do |file|
            file.write(uploaded_io.read)
          end
          picture = Image.new
          picture.date = Time.now
          picture.url = uploaded_io.original_filename
          picture.tool_id = params[:tool_id]
          picture.review_id = @review.id
          if !picture.save
            flash[:alert] = "The picture #{picture.file_name} is failed in uploading to the server."
          end
        end
      end
    end

end
