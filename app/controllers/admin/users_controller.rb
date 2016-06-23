class Admin::UsersController < ApplicationController
  before_action :logged_in_user, :authorize_admin

  def index
    @users = User.paginate page: params[:page], per_page: Settings.users_per_page
  end
end
