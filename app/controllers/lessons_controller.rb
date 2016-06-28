class LessonsController < ApplicationController
  before_action :logged_in_user

  def create
    lesson = Lesson.new category_id: params[:category_id], user_id: current_user.id
    if lesson.save
      flash[:success] = t "controllers.lessons.flash.success.create_lesson"
      redirect_to categories_path
    else
      flash[:danger] = t "controllers.lessons.flash.danger.create_lesson"
      redirect_to categories_path
    end
  end
end
