class Admin::WordsController < ApplicationController
  before_action :logged_in_user, :authorize_admin
  before_action :load_word, only: :destroy
  before_action :check_lesson_words, only: :destroy

  def index
    @words = Word.order(:created_at).paginate page: params[:page],
      per_page: Settings.words_per_page
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t "controllers.admin.categories.flash.success.create_word"
      redirect_to admin_words_path
    else
      render :new
    end
  end

  def destroy
    @word.destroy
    flash[:success] = t "controllers.admin.words.flash.success.delete_word"
    redirect_to admin_words_path
  end

  def check_lesson_words
    if @word.lesson_words.any?
      flash[:danger] = t "controllers.admin.words.flash.danger.delete_word"
      redirect_to admin_words_path
    end
  end

  private
  def word_params
    params.require(:word).permit category_id :name
  end

  def load_word
    @word = Word.find_by id: params[:id]
    unless @word
      flash[:danger] = t "controllers.application.flash.danger.invalid_word"
      redirect_to root_url
    end
  end
end


