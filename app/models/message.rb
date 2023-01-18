class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  after_create_commit  :broadcast_room_messages, on: :create

  private

  def broadcast_room_messages
    broadcast_append_to('room_messages_channel', partial: 'messages/message', locals: {message: self}, target: 'room_messages_div')
  end
end
