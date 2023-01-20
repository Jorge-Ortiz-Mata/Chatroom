class Room < ApplicationRecord
  validates :name, presence: true
  has_many :messages
  has_many :room_users
  has_many :users, through: :room_users

  after_update_commit  :update_room_details

  private

  def update_room_details
    broadcast_replace_to('room_details_channel', partial: 'sidebar/single_room', locals: {room: self}, target: "room_#{id}")
  end
end
