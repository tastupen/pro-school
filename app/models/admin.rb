class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :image
  has_many :rooms
  has_many :lessons, dependent: :destroy

  has_many :reservations, dependent: :destroy

  def self.search(words)
    @user = Admin.where("name LIKE ? OR description LIKE ? ", "%#{words}%", "%#{words}%" )
  end
end
