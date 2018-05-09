class ToolsController < ApplicationController
  before_action :load_tool, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except:[:index, :show]
  before_action :require_user_authority, only: [:edit, :update, :destroy]

  impressionist actions: [:show]

  def index
    if params[:tool]
      @tools = Tool.search(params[:tool], params[:nbhd])
    else
      @tools = Tool.all
    end
    @nbhd = Neighbourhood.find_by(name: params[:nbhd])
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(params.require(:tool).permit(:name, :description, :condition, :loan_length, {owner_pictures: []}, :category_ids, :image_ids))

    @tool.on_loan = false
    @tool.user_id = current_user.id

    if params[:tool][:owner_pictures] != nil
      if @tool.save
        @tool_cat_ids = []
        write_tool_category
        redirect_to tool_url(@tool)
      else
        render :new
      end
    else
      @tool.errors[:tool] << "must contain at least one photo"
      render :new
    end
  end

  def edit
  end

  def update
    if request.xhr?
      Tool.update(@tool.id, on_loan: false)
    else
      @tool.name = params[:tool][:name]
      @tool.description = params[:tool][:description]
      @tool.condition = params[:tool][:condition]
      @tool.loan_length = params[:tool][:loan_length]

      Tool.update(@tool.id, params.require(:tool).permit(:name, :description, :condition, :loan_length, {owner_pictures: []}, :category_ids, :image_ids))

      if params[:tool][:owner_pictures] == nil && @tool.owner_pictures.count == 0
        @tool.errors[:tool] << "must contain at least one photo"
        render :edit
      else
        if @tool.save
          remove_categories
          write_tool_category
          redirect_to tool_url(@tool)
        else
          render :edit
        end
      end
    end
  end

  def show
    @tool = Tool.find(params[:id])

    if current_user
      Chat.where("tool_id = ?", @tool.id).where("user_id = ?", current_user.id).where("owner_reply = ?", true).update_all(unread: false)

      @chats = Chat.where("user_id = ?", current_user.id).where("tool_id = ?", params[:id]).order(created_at: :asc)
    end

    @chat = Chat.new

    @review = Review.new
    @reviews = @tool.reviews.order(created_at: :desc)

    @rating = Rating.where(review: @review).first
    unless @rating
      @rating = Rating.create(review: @review, score: 0)
    end

    owner_location = JSON.parse(HTTParty.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{@tool.owner.postal_code.split.join('+')},Toronto&bounds=43.855458,-79.002481|43.458297,-79.639219&key=#{ENV['GOOGLE_MAPS_KEY']}").body)["results"][0]["geometry"]["location"]

    @lat = owner_location["lat"]
    @lng = owner_location["lng"]
  end

  def destroy
    @tool.destroy
    flash[:notice] = "You have successfully deleted this tool."
    redirect_to tools_url
  end

  def load_tool
    @tool = Tool.find(params[:id])
  end

  def require_user_authority
    unless current_user == @tool.owner
      flash[:alert] = "You are not authorized to modify this tool."
      redirect_to login_url
    end
  end

  def remove_categories
    @tool_cat_ids = @tool.categories.ids.map {|x| x.to_s }
    remove_list = @tool_cat_ids - params[:tool][:category_ids]
    remove_list.each do |cat_id|
      @tool_category = Categorization.find_by(category_id: cat_id.to_i)
      @tool.categories.delete(cat_id.to_i)
    end
  end

  def write_tool_category
    params[:tool][:category_ids].each do |cat_id|
      unless cat_id == "" || @tool_cat_ids.include?(cat_id)
        @tool_category = Categorization.new
        @tool_category.tool_id = @tool.id
        @tool_category.category_id = cat_id
        @tool_category.save
      end
    end
  end

end
