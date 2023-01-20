class Message < ApplicationRecord
  attr_accessor :current_logged_user_in
  belongs_to :room
  belongs_to :user

  after_create_commit  :broadcast_room_messages_create
  after_update_commit  :broadcast_room_messages_update
  after_destroy_commit :broadcast_room_messages_destroy

  private

  def broadcast_room_messages_create
    broadcast_append_to('room_messages_channel', partial: 'messages/message', locals: {message: self, room: self.room}, target: 'room_messages_div')
  end

  def broadcast_room_messages_update
    broadcast_replace_to('room_messages_channel', partial: 'messages/message', locals: {message: self, room: self.room}, target: "message_#{id}")
  end

  def broadcast_room_messages_destroy
    broadcast_remove_to('room_messages_channel', target: self)
  end
end
