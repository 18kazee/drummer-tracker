class PostsController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    set_drummer
    set_posts
    @drummers = Drummer.all
    @post = Post.new
  end

  def create
    set_posts
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        flash.now[:success] = "投稿しました"
        format.turbo_stream
      else
        flash.now[:danger] = "投稿に失敗しました"
        format.turbo_stream
      end
    end
  end

  def show
    set_drummer
    @post = Post.find(params[:id])
  end
 
  def destroy
    @post = Post.find(params[:id])
    respond_to do |format|
    @post.destroy
    flash.now[:success] = "投稿を削除しました"
    format.turbo_stream
  end
  end

  private

  def post_params
    params.require(:post).permit(:tweet, :drummer_id, :user_id)
  end

  def set_drummer
    @drummer_id = params[:drummer_id]
    @drummer_name = params[:drummer_name]
  end

  def set_posts
    @posts = Post.all.order("created_at DESC").page(params[:page])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
