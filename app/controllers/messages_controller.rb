class MessagesController < ApplicationController
  before_action :set_room, only: %i[create]
  before_action :set_message, only: %i[ show edit update destroy ]

  # def edit
  # end

  def create
    @message = @room.messages.new message_params
    @message.user = current_user

    respond_to do |format|
      if @message.save
        format.turbo_stream
        format.js {
          render  :template => "app/helpers/message.js.erb",
                  :layout => false
          }
      end
    end
  end

  # def update
  #   respond_to do |format|
  #     if @message.update(message_params)
  #       format.html { redirect_to message_url(@message), notice: "Message was successfully updated." }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
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
