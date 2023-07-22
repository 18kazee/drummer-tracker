class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password, length: { minimum: 5 }, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true

  def send_activation_needed_email
    UserMailer.activation_needed_email(self).deliver_now
  end

end
