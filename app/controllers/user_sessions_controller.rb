class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create guest_login] 

  def new; end

  def create
    if login(params[:email], params[:password])
      redirect_back_or_to root_path, success: t('.success')
    else
      flash.now[:danger] = t('.failed')
      render 'new', status: :unauthorized
    end
  end

  def destroy
    logout
    redirect_to root_path, success: t('.success')
  end

  def guest_login
    @guest_user = User.create(
      name: 'ゲスト',
      email: SecureRandom.alphanumeric(10) + '@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    auto_login(@guest_user)
    redirect_to root_path, success: t('.success')
  end
end
