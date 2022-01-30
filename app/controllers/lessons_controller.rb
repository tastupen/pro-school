class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show]
  def index
    @lessons = Lesson.all.order("created_at DESC")
    @categories = Category.all
  end

  def show
    @categories = Category.all
  end

  private
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end
end
