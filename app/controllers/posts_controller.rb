class PostsController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    set_posts
    @drummer_id = params[:drummer_id]
    @drummer_name = params[:drummer_name]
    @drummers = Drummer.all
    @post = Post.new
  end

  def create
    set_posts
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
    set_post
    @drummer_name = Drummer.find(@post.drummer_id).name
    @drummer_id = Drummer.find(@post.drummer_id).id
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("post_#{@post.id}") }
      format.html 
    end
  end

  def update
    set_post
    set_posts
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
    set_post
    respond_to do |format|
      @post.destroy
      flash.now[:success] = t(".success")
      format.turbo_stream
    end
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
