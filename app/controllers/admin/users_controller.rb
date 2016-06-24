class Admin::UsersController < ApplicationController
  before_action :logged_in_user, :authorize_admin
  before_action :load_user, only: :destroy

  def index
    @users = User.order(:created_at).paginate page: params[:page],
      per_page: Settings.users_per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t "controllers.admin.users.flash.success.delete_user"
    else
      flash[:danger] = t "controllers.admin.users.flash.fail.delete_user"
    end
    redirect_to admin_users_path
  end
end
