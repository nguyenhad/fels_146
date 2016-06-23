class FollowingsController < ApplicationController
  before_action :load_user

  def index
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.users_per_page
  end
end
