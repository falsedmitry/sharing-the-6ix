class ToolsController < ApplicationController
  before_action :load_tool, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except:[:index]
  before_action :require_user_authority, only: [:edit, :update, :destroy]

  def index
    @tools = Tool.all
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new

    @tool.name = params[:tool][:name]
    @tool.description = params[:tool][:description]
    @tool.condition = params[:tool][:condiitons]
    @tool.loan_length = params[:tool][:loan_length]
    @tool.on_loan = false
    @tool.user_id = current_user.id

      if @tool.save
        redirect_to tools_url
      else
        render :new
      end
    end

  def edit

  end

  def update
    @tool.name = params[:tool][:name]
    @tool.description = params[:tool][:description]
    @tool.condition = params[:tool][:condiitons]
    @tool.loan_length = params[:tool][:loan_length]

      if @tool.save
        redirect_to tools_url
      else
        render :edit
      end
    end


  def show
    @tool = Tool.find(params[:id])
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
end
