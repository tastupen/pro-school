class DashboardController < ApplicationController
  before_action :authenticate_admin!
  layout 'dashboard/dashboard'
  
  def index
    @admin = current_admin
    @lessons = current_admin.lessons.limit(3)
    @lesson_ranking = current_admin.lessons.find(Like.group(:lesson_id).order('count(lesson_id) desc').pluck(:lesson_id))
    @lesson_comment_rank = current_admin.lessons.find(Comment.group(:lesson_id).order('count(lesson_id) desc').pluck(:lesson_id))
  end
end
