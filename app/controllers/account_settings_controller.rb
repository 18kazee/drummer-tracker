class AccountSettingsController < ApplicationController
  include PasswordResetHelper

  skip_before_action :require_login, only: [:edit_password, :check_password]

  def show
    @user = current_user
    if session[:authenticated_for_settings]
      render :show
    else
      redirect_to password_confirmation_account_settings_path
    end
  end

  def edit_password
    @user = current_user
  end

  def send_password_reset_link
    send_reset_link_to_email(current_user.email)
    flash[:success] = 'パスワード再設定用のメールを送信しました。'
    redirect_to account_setting_path(current_user)
  end

  def check_password
    if current_user.valid_password?(params[:password])
      session[:authenticated_for_settings] = true
      flash[:success] = 'パスワードが確認できました。'
      redirect_to account_setting_path(current_user)
    else
      flash[:danger] = 'パスワードが間違っています。'
      render :password_confirmation, status: :unauthorized
    end
  end

  def update_email
    user = current_user
    new_email = params[:new_email]
    token = SecureRandom.urlsafe_base64
    expiration_time = Time.zone.now + 30.minutes

    if user.update(new_email:, activation_token: token, activation_token_expires_at: expiration_time)
      UserMailer.send_email_change_activation(user, token, new_email).deliver_now
      flash[:success] = '確認メールを送信しました。メールを確認してください。'
      redirect_to account_setting_path(current_user)
    else
      flash[:danger] = 'メールを送信できませんでした。'
      render :show, status: :internal_server_error
    end
  end

  def activate_email_change
    user = current_user
    token = params[:token]

    if user.activation_token == token && user.activation_token_expires_at > Time.zone.now
      user.update(email: user.new_email, new_email: nil, activation_token: nil)
      flash[:success] = 'メールアドレスを変更しました。'
    else
      flash[:danger] = 'メールアドレスの変更に失敗しました。'
    end
    redirect_to account_setting_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :avatar_cache)
  end
end
