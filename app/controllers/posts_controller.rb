class PostsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  skip_before_action :redirect_if_logged_in
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_posts, only: [:index, :create, :update, :destroy]

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
    @comments = @post.comments.includes(:user).order("created_at DESC")
    @comment = Comment.new
  end

  def edit
    @drummer_name = Drummer.find(@post.drummer_id).name
    @drummer_id = Drummer.find(@post.drummer_id).id
  end

  def update
    if @post.update(post_params)
      flash[:success] = t(".success")
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to post_path(@post) }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash.now[:success] = t(".success")
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_path }
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
