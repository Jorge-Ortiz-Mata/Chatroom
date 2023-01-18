class RoomUser < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_commit on: :create do
    broadcast_append_to(
      @room_users_channel,
      partial: 'sidebar/single_room',
      locals: {room: Room.find(room_id)},
      target: "user_#{user_id}_rooms"
    )
  end
end
