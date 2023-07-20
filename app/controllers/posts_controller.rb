class PostsController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    set_drummer
    set_posts
    @drummers = Drummer.all
  end

  def new
    set_drummer
    @post = Post.new
  end

  def create
    set_posts
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash.now[:success] = "投稿しました"
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("posts", partial: "posts/post_cards", locals: { post: @post }),
            turbo_stream.append("flash", partial: "shared/flash_message", locals: { flash_message: flash[:success] })
          ]
        end
      end
    else
   flash.now[:danger] = "投稿に失敗しました"
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append("flash", partial: "shared/flash_message", locals: { flash_message: flash[:danger] })
      end
      format.html { render 'new', status: :unprocessable_entity }
    end
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
end
