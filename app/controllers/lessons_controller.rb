class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show]
  def index
    if sort_params.present?
      @category = Category.request_category(sort_params[:sort_category])
      @lessons = Lesson.sort_products(sort_params, params[:page])
    elsif params[:category].present?
      @category = Category.request_category(params[:category])
      @lessons = Lesson.category_products(@category, params[:page])
    else
      @lessons = Lesson.display_list(params[:page])
    end

    @categories = Category.all
    @major_category_names = Category.major_categories
    @sort_list = Lesson.sort_list
    @user = current_user
  end

  def show
    @categories = Category.all
    @major_category_names = Category.major_categories
    @user = current_user
    @comments = @lesson.comments_with_id
    @comment = @comments.new
  end

  private
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def sort_params
      params.permit(:sort, :sort_category)
    end
end
