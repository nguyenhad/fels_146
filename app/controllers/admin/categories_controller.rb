class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user, :authorize_admin
  before_action :load_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.order(:created_at).paginate page: params[:page],
      per_page: Settings.categories_per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "controllers.admin.categories.flash.success.create_category"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "controllers.admin.categories.flash.success.edit_category"
      redirect_to root_url
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    flash[:success] = t "controllers.admin.categories.flash.success.delete_category"
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash[:danger] = t "controllers.application.flash.danger.invalid_category"
      redirect_to root_url
    end
  end
end
