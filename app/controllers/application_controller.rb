class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      flash[:warning] = t "log_in_require"
      redirect_to root_url
    end
  end

  def authorize_user
    unless @user.is_user? current_user
      flash[:danger] = t "no_permission"
      redirect_to root_url
    end
  end
end
