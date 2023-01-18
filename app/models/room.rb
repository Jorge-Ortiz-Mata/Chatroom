class Room < ApplicationRecord
  validates :name, presence: true
  has_many :messages
  has_many :room_users
  has_many :users, through: :room_users
end
