class MessagesController < ApplicationController
  before_action :set_room

  def create
    @message = @room.messages.build(message_params)
    @message.user = current_user
    return unless @message.save

    RoomChannel.broadcast_to(@room, data: { message: @message.content, user: @message.user })
  end

  private

  def render_message(message)
    render(partial: 'messages/message', locals: { message: })
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
