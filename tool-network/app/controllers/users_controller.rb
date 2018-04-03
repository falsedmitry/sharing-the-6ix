class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    @user.photo = params[:user][:photo]
    @user.location = params[:user][:location]

    if @user.save
      redirect_to tools_url
    else
      flash[:error] = "Something went wrong"
      render :new
    end
  end
  
  def show
  end

  def update
  end

  def edit

  end

  def destroy
  end

  # private
  # def load_user
  #   @user = User.find(params[:user_id])
  # end
  #

end
