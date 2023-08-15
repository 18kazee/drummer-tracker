class PostsController < ApplicationController
  skip_before_action :require_login, only: [:index]
  skip_before_action :redirect_if_logged_in
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_posts, only: [:index, :create, :update]

  def index
    @drummer_id = params[:drummer_id]
    @drummer_name = params[:drummer_name]
    @drummers = Drummer.all
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        flash.now[:success] = t(".success")
        format.turbo_stream
      else
        flash.now[:danger] = t(".failed")
        format.turbo_stream
      end
    end
  end

  def show
    @post = Post.find(params[:id]) 
  end

  def edit
    @drummer_name = Drummer.find(@post.drummer_id).name
    @drummer_id = Drummer.find(@post.drummer_id).id
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("post_#{@post.id}") }
      format.html 
    end
  end

  def update
    if @post.update(post_params)
      flash.now[:success] = t(".success")
      respond_to do |format|
        format.turbo_stream
        format.html { render :edit } 
      end
    else
      flash.now[:danger] = t(".failed")
      respond_to do |format|
        format.turbo_stream
      end
    end
  end

  def destroy
    respond_to do |format|
      @post.destroy
      flash.now[:success] = t(".success")
      format.turbo_stream
    end
  end

  def likes
    @liked_posts = current_user.liked_posts
  end

  private

  def post_params
    params.require(:post).permit(:tweet, :drummer_id, :user_id)
  end

  def set_posts
    @posts = Post.all.order("created_at DESC").page(params[:page])
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end
end
