class UserMailer < ApplicationMailer
  default from: "info@drummer-tracker.com"

  def reset_password_email(user)
    @user = User.find(user.id)
    @url = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email, subject: 'パスワードリセット')
  end

  def activation_needed_email(user)
    return if user.guest?
    @user = user
    @url  = activate_user_url(@user.activation_token)
    mail(to: user.email, subject: 'DrummerTrackerアカウントの認証')
  end

  def activation_success_email(user)
   @user = user
   @url  = login_url
   mail(to: user.email, subject: 'DrummerTrackeアカウントが認証されました')
  end
end
