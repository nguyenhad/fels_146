class UsersController < ApplicationController
  USERS_PER_PAGE = 10

  before_action :logged_in_user, only: [:index]

  def index
    @users = User.paginate page: params[:page], per_page: USERS_PER_PAGE
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
      redirect_to @user
    else
      render :new
    end
  end
  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                    :password_confirmation
  end
end
