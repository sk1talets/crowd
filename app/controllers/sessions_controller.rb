class SessionsController < ApplicationController
  before_filter :is_authenticated, :except => [:new, :create] 

  def new
  end
  
  def create
    user = User.find_by(name: params[:session][:name])
    if user and user.authenticate(params[:session][:password])
      log_in user
      redirect_to posts_path
    else
      flash.now[:danger] = 'faled to login'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
