class ToolsController < ApplicationController
  before_action :require_login, except:[:index]

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
    @tool = Tool.find(params[:id])
  end

  def update
    @tool = Tool.find(params[:id])
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
    @tool = Tool.find(params[:id])
    @tool.destroy
    flash[:notice] = "You have successfully deleted this tool."
    redirect_to tools_url
  end
end
