class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :admin

  has_many_attached :images

  has_many :reservations

  has_many :likes

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :category_id, presence: true
  
  PER = 9

  scope :display_list, -> (page) { page(page).per(PER) }
  scope :on_category, -> (category) { where(category_id: category) }
  scope :sort_order, -> (order) { order(order) }

  scope :category_products, -> (category, page) { 
    on_category(category).
    display_list(page)
  }

  scope :sort_products, -> (sort_order, page) {
    on_category(sort_order[:sort_category]).
    sort_order(sort_order[:sort]).
    display_list(page)
  }

  scope :sort_list, -> { 
    {
      "並び替え" => "", 
      "価格の安い順" => "price asc",
      "価格の高い順" => "price desc", 
      "出品の古い順" => "updated_at asc", 
      "出品の新しい順" => "updated_at desc"
    }
  }

  def self.search(words)
    @lessons = Lesson.joins(:category).where("lessons.name LIKE ? OR lessons.description LIKE? OR major_category_name LIKE ? OR categories.name LIKE ? ", "%#{words}%", "%#{words}%", "%#{words}%", "%#{words}%" )
  end
end
