class Category < ApplicationRecord
  has_many :lessons

  scope :major_categories, -> { pluck(:major_category_name).uniq }
  scope :request_category, -> (category) {
    if category != "none"
      find(category.to_i)
    else
      ""
    end
  }
end
