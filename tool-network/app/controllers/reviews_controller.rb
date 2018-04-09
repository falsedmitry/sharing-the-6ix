class ReviewsController < ApplicationController
  before_action :load_review, only: [:edit, :update, :destroy]
  before_action :load_tool

  def create
    @tool = Tool.find(params[:tool_id])
    @reviews = @tool.reviews.order(created_at: :desc)
    @review = Review.new(params.require(:review).permit(:comment, :rating, {images: []}))

    @review.tool_id = params[:tool_id]
    @review.user_id = current_user.id

    if params[:review][:images] != []
      if @review.save
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
  end

  def update
    @tool = Tool.find(params[:tool_id])
    @reviews = @tool.reviews.order(created_at: :desc)

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

    def remove_pictures
      params[:review][:image_ids].each do |image_id|
        unless image_id == ""
          @image = Image.find(image_id)
          File.delete(@@review_image_path.join(@image.url))
          @image.destroy
        end
      end
    end

    def remove_picture_files
      @review.images.each do |image|
        @image = Image.find(image.id)
        File.delete(@@review_image_path.join(image.url))
        @image.destroy
      end
    end

    def upload_pictures
      unless params[:review][:picture] == nil
        uploaded_ios = params[:review][:picture]
        uploaded_ios.each do |uploaded_io|
          img_file = @@prefix + uploaded_io.original_filename
          File.open(@@review_image_path.join(img_file), 'wb') do |file|
            file.write(uploaded_io.read)
          end

          picture = Image.new
          picture.url = img_file
          picture.tool_id = params[:tool_id]
          picture.review = @review
          if !picture.save
            flash[:alert] = "The picture #{img_file} is failed in uploading to the server."
          end
        end
      end
    end

end
