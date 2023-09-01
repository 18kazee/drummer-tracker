class Message < ApplicationRecord
  after_create_commit :broadcast_message

  belongs_to :user
  belongs_to :room

  def broadcast_message
    RoomChannel.broadcast_to(room, self)
  end
end
