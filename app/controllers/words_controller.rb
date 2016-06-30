class WordsController < ApplicationController
  def index
    @categories = Category.all
    if Settings.filter_options.include? params[:filter]
      filter = params[:filter]
    else
      filter = Settings.filter_options.last
    end
    @words = Word.in_category(params[:category_id])
      .send(filter, current_user.id).paginate page: params[:page],
      per_page: Settings.words_per_page
  end
end
