class CommentsController < ApplicationController
  def create
    lesson = Lesson.find(params[:lesson_id])
    comment = lesson.comments_new
    comment.save_comment(comment, comment_params)
    redirect_to lesson_url(lesson)
  end

  def comment_params
    params.require(:comment).permit(:content, :rate).
           merge(user_id: current_user.id, lesson_id: params[:lesson_id])
  end
end
