class WebController < ApplicationController
  def index
    @lessons = Lesson.all.order("created_at DESC")
    @categories = Category.all
    @major_category_names = Category.major_categories
    @user = current_user
  end
end
