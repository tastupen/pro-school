class Dashboard::LessonsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_lesson, only: %w[show edit update destroy]
  layout 'dashboard/dashboard'

  def index
    @lessons = current_admin.lessons.all.order("created_at DESC")
  end

  def new
    @lesson = current_admin.lessons.new
    @categories = Category.all
  end

  def create
    @lesson = current_admin.lessons.new(lesson_new_params)
    if @lesson.save
      redirect_to dashboard_lessons_path, flash: { success: "レッスン投稿に成功しました!" }
    else
      redirect_to new_dashboard_lesson_path, flash: { danger: 'レッスンの投稿に失敗しました。' }
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    respond_to do |format|
      if @lesson.update(lesson_update_params)
        format.html {redirect_to dashboard_lessons_path }
        format.json {flash.now[:notice] = "更新に成功しました" }
        format.js { @status = "success"}
      else
        format.js { @status = "false" }
      end
    end
  end

  def destroy
    @lesson.destroy
    redirect_to dashboard_lessons_path, flash: { success: "削除に成功しました！" } 
  end

  private
    def set_lesson
      @lesson = current_admin.lessons.find(params[:id])
    end

    def lesson_new_params
      params.permit(:name, :description, :price, :category_id, :admin_id, images: [])
    end

    def lesson_update_params
      params.require(:lesson).permit(:name, :description, :price, :category_id, :admin_id, images: [])
    end
end
