class UsersController < ApplicationController
  before_filter :is_authenticated, :except => [:new, :create] 

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash = { success: "Welcome to the Crowd, #{@user.name}!"}
      redirect_to posts_path
    else
      render 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
   
    redirect_to users_path
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
