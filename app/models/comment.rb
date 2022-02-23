class Comment < ApplicationRecord

  belongs_to :lesson
  belongs_to :user

  scope :comments_with_id, -> { where.not(lesson_id: nil) }

  def save_comment(comment, comment_params)
    comment.content = comment_params[:content]
    comment.rate = comment_params[:rate]
    comment.user_id = comment_params[:user_id]
    comment.lesson_id = comment_params[:lesson_id]
    save
  end
  
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true
end
