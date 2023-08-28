class LikesController < ApplicationController
  skip_before_action :require_login
  before_action :set_post, only: [:create, :destroy]

  def create
    current_user.like(@post)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    current_user.unlike(@post)
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
