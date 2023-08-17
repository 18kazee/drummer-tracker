class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password, length: { minimum: 5 }, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true

  has_many :posts, dependent: :destroy
  has_many :user_answers, dependent: :destroy
  has_many :recommended_drummers, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post   # ユーザーがいいねした投稿を取得
  has_many :comments, dependent: :destroy

  def send_activation_needed_email
    return if guest? || persisted? # ゲストユーザーでない場合かつ未保存の場合にメールを送信

    UserMailer.activation_needed_email(self).deliver_now
  end

  def resend_activation_email
    # アクティベーショントークンの再生成
    restore_activation_token!

    # アクティベーションメールの再送信
    UserMailer.activation_needed_email(self).deliver_now
  end

  def mine?(object)
    id == object.user_id
  end

  def like(post)
    liked_posts << post
  end

  def unlike(post)
    liked_posts.delete(post)
  end

  # いいねしているかどうかの判定メソッド
  def like?(post)
    liked_posts.include?(post)
  end
end
