class LikesController < ApplicationController
  def create
    Like.create(user_id: current_user.id, lesson_id: params[:id])
    redirect_to lesson_path
  end

  def destroy
    Like.find_by(user_id: current_user.id, lesson_id: params[:id]).destroy
    redirect_to lesson_path
  end
end
