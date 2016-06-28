class Admin::WordsController < ApplicationController
  before_action :logged_in_user, :authorize_admin
  before_action :load_category, only: :new
  before_action :load_word, only: [:edit, :update]

  def new
    @word = @category.words.build
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t "controllers.admin.words.flash.success.create_word"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
    @word_answers = @word.word_answers
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "controllers.admin.words.flash.success.update_word"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  private
  def load_category
    @category = Category.find_by id: params[:category_id]
    unless @category
      flash[:danger] = t "controllers.application.flash.danger.invalid_category"
      redirect_to admin_categories_path
    end
  end

  def word_params
    params.require(:word).permit :category_id, :name,
      word_answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_word
    @word = Word.find_by id: params[:id]
    unless @word
      flash[:danger] = t "controllers.application.flash.danger.invalid_word"
      redirect_to admin_categories_path
    end
  end
end
