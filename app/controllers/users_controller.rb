class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index]
  def index
    @users = User.all
  end

  def show
    @user = User.find_by id: params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "create"
      redirect_to root_url
    else
      render :new
    end
  end
  private

    def user_params
      params.require(:user).permit :name, :email, :password,
                                    :password_confirmation
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = t "Log_in.log_in_warn"
        redirect_to login_url
      end
    end
  end
