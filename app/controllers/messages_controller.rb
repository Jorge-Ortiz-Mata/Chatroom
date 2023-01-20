class MessagesController < ApplicationController
  before_action :set_room, only: %i[create]

  def message_edit
    @message = Message.find(params[:message])
  end

  def create
    @message = @room.messages.new message_params
    @message.user = current_user

    respond_to do |format|
      if @message.save
        format.turbo_stream
      end
    end
  end

  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update message_params
        format.turbo_stream
      end
    end
  end

  def destroy
    @message = Message.find(params[:message])
    @message.destroy

    respond_to do |format|
      format.turbo_stream
    end
  end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def set_room
      @room = Room.find(params[:room_id])
    end

    def message_params
      params.require(:message).permit(:name)
    end
end
