class UsersController < ApplicationController

  before_action :load_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new

    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.location = params[:user][:location]
    @user.neighbourhood = Neighbourhood.find_by(name: params[:user][:neighbourhood])
    @user.avatar = params[:user][:avatar]

    if @user.save
      session[:user_id] = @user.id
      redirect_to tools_url
    else
      puts @user.errors.full_messages
      flash[:error] = "Something went wrong"
      render :new
    end
  end

  def show
    @owned_tools = @user.owned_tools.uniq
    @borrowed_tools = @user.borrowed_tools.uniq
    @tools_out_on_loan = @user.tools_out_on_loan.uniq
  end

  def edit
  end

  def update
    @user.email = params[:user][:email]
    @user.photo = params[:user][:photo]
    @user.location = params[:user][:location]

    if @user.save
      redirect_to user_url
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.find(params[:id])
  end


end
