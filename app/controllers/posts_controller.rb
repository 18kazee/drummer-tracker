class PostsController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @posts = Post.all.order("created_at DESC").page(params[:page])
    @drummers = Drummer.all
  end

  def new
    @post = Post.new
  end

  def create
    @posts = Post.all.order("created_at DESC").page(params[:page])
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash.now.notice = "Post created"
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("posts", partial: "posts/post_cards", locals: { post: @post }) }    
       end
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:tweet, :drummer_id, :user_id)
  end
end
