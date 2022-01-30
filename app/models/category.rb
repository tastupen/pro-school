class Category < ApplicationRecord
  has_many :lessons

  scope :major_categories, -> { pluck(:major_category_name).uniq }
end
