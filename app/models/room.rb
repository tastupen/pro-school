class Room < ApplicationRecord
  belongs_to :user
  belongs_to :admin
  
  has_many :messages
end
