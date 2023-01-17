class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  after_commit on: :create do
    broadcast_append_to(
      @messages_channel,
      partial: 'messages/message',
      locals: {message: self},
      target: "room_messages_#{self.room.id}"
    )
  end
end
