class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password, length: { minimum: 5 }, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true

  has_many :posts, dependent: :destroy

  def send_activation_needed_email
    return if guest? || persisted?  # ゲストユーザーでない場合かつ未保存の場合にメールを送信

    UserMailer.activation_needed_email(self).deliver_now
  end
end
