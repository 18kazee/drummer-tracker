class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :activate, :resend_activation_form, :resend_activation] 
  skip_before_action :redirect_if_logged_in, only: [:edit, :show, :update, :create, :posts_user, :activate]

  # User Registration
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params_create)
    # If user is saved successfully than show message
    if @user.save
      @user.send_activation_needed_email
      redirect_to login_path, success: '登録用のメールを送信しました。メールをご確認ください。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = current_user
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def update
    @user = current_user
    if @user.update(user_params_update)
      redirect_to user_path(@user), success: 'プロフィールを更新しました。'
    else
      puts @user.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def posts_user
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      redirect_to login_path, success: '会員登録が完了しました。'
    else
      not_authenticated
    end
  end

  def resend_activation_form; end
  
  def resend_activation
    user = User.find_by(email: params[:email])
    if user && user.activation_state != 'active'
      # activation_stateが'active'でない場合のみ再送信
      user.resend_activation_email
    end
    flash[:success] = '確認メールを再送信しました。'
    redirect_to new_user_path
  end

  private

  def user_params_create
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :salt, :avatar, :avatar_cache)
  end

  def user_params_update
    params.require(:user).permit(:name, :avatar, :avatar_cache)
  end
end
