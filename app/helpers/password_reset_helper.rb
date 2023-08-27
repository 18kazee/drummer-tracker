module PasswordResetHelper
  def send_reset_link_to_email(email)
    user = User.find_by(email:)

    return unless user

    user.deliver_reset_password_instructions!
  end
end
