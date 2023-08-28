class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :guest_login] 

  def new
    if logged_in?
      redirect_to root_path
    end
  end

  def create
    if login(params[:email], params[:password])
      cookies.encrypted[:user_id] = current_user.id
      redirect_back_or_to root_path, success: t('.success')
    else
      flash.now[:danger] = t('.failed')
      render 'new', status: :unauthorized
    end
  end

  def destroy
    logout
    redirect_to login_path, success: t('.success')
  end

  def guest_login
    @guest_user = User.new(
      name: 'ゲスト',
      email: SecureRandom.alphanumeric(10) + '@example.com',
      password: 'password',
      password_confirmation: 'password',
      guest: true
    )
    
    return unless @guest_user.save

    cookies.encrypted[:user_id] = @guest_user.id
    auto_login(@guest_user)
    redirect_to root_path, success: t('.success')
    
  end
end
