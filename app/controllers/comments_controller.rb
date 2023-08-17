class CommentsController < ApplicationController
  skip_before_action :redirect_if_logged_in
  skip_before_action :require_login
  before_action :set_post

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    if @comment.save
      ActionCable.server.broadcast "comment_channel", { comment: @comment, user: current_user, action: 'create' }
    else
      render 'posts/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    ActionCable.server.broadcast "comment_channel", { action: 'delete', comment_id: @comment.id }
    redirect_to @comment.post, notice: "Comment deleted"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
