class SessionsController < ApplicationController
  before_action :already_logged_in, only: [:new, :create]
  before_action :not_logged_in, only: [:destroy]

  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_path
    else
      flash.now[:danger] = t "controllers.sessions.flash.danger.login"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private
  def already_logged_in
    if logged_in?
      redirect_to root_path
    end
  end

  def not_logged_in
    unless logged_in?
      redirect_to root_path
    end
  end
end
