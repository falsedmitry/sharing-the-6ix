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
      redirect_to tool_url(params[:tool_id])
    end
  end

  def edit
    @tool = @review.tool
  end

  def update
    @review.comment = params[:review][:comment]
    @review.rating = params[:review][:rating]

    if @review.save
      remove_pictures
      upload_pictures
      redirect_to tool_url(params[:tool_id])
    else
      flash[:alert] = "Comment cannot be empty!"
      redirect_to tool_url(params[:tool_id])
    end
  end

  def destroy
    remove_picture_files
    @review.destroy
    flash[:notice] = "You have successfully deleted the comment!"
    redirect_to tool_url(params[:tool_id])
  end

  private
    def load_review
      @review = Review.find(params[:id])
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
          picture.date = Time.now
          picture.url = img_file
          picture.tool_id = params[:tool_id]
          picture.review_id = @review.id
          
          if !picture.save
            flash[:alert] = "The picture #{picture.file_name} is failed in uploading to the server."
          end
        end
      end
    end

end
