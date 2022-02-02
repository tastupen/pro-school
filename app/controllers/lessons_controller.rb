class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show]
  def index
    @lessons = Lesson.display_list(category_params)
    @category = Category.request_category(category_params)
    @categories = Category.all
    @major_category_names = Category.major_categories
    @user = current_user
  end

  def show
    @categories = Category.all
    @major_category_names = Category.major_categories
    @user = current_user
  end

  private
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def category_params
      params[:category].present? ? params[:category]
                                 : "none"
    end
end
