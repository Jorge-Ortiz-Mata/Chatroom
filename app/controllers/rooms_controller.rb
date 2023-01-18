class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]

  def index
    @rooms = Room.all
  end

  def show
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        RoomUser.create(room: @room, user: current_user)
        format.turbo_stream { render turbo_stream: turbo_stream.append('rooms', partial: 'sidebar/single_room', locals: { room: @room }) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('form_room_component', partial: 'rooms/form', locals: { room: @room }) }
      end
    end
  end

  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to room_url(@room), notice: "Room was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @room.destroy

    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
    end
  end

  def add_user
    RoomUser.create!(user_id: params[:user_id], room_id: params[:room_id])
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:name)
    end
end
