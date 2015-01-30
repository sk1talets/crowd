class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  include SessionsHelper

  def is_authenticated
    if !logged_in?
      if request and request.xhr?
        render :status => 403
      else
        redirect_to login_path
      end
    end
  end
end
