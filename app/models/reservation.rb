class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :admin
  belongs_to :lesson

  validates :lesson_id, presence: true
  validates :user_id, presence: true
  validates :start_time, uniqueness: true
end
