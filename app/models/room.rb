class Room < ApplicationRecord
  has_many :messages
  has_many :room_users
  has_many :users, through: :room_users

  after_commit on: :create do
    broadcast_append_to(
      @rooms_channel,
      partial: 'rooms/single_room',
      locals: {room: self},
      target: "rooms"
    )
  end
end
