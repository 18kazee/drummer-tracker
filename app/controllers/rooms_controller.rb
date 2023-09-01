class RoomsController < ApplicationController
  before_action :set_room, only: [:show]

  def index
    @rooms = Room.all
  end

  def show
    # メッセージ送信用の新しいインスタンスも作成しておきます。
    @message = Message.new
    @post = Post.find(params[:id])
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end
end
