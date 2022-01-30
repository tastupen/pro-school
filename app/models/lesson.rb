class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :admin

  has_many_attached :images

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :category_id, presence: true
end
