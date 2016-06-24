class CategoriesController < ApplicationController
  before_action :logged_in_user, :load_categories

  def index
  end

  def load_categories
    @categories = Category.paginate page: params[:page],
      per_page: Settings.categories_per_page
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
