class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_one_attached :user_image

  has_many :rooms

  has_many :likes

  has_many :comments

  def liked_by?(lesson_id)
    likes.where(lesson_id: lesson_id).exists?
  end

  has_many :reservations, dependent: :destroy

  def self.search(words)
    @user = User.where("name LIKE ?", "%#{words}%")
  end

  def update_password(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    result = update(params, *options)
    clean_up_passwords
    result
  end
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
