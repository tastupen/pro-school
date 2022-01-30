class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show]
  def index
    @lessons = Lesson.all.order("created_at DESC")
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
end
