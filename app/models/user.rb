class User < ApplicationRecord
  authenticates_with_sorcery!

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true, on: [:create, :account_settings_update]
  validates :password, presence: true, on: :create
  validates :password, length: { minimum: 5 }, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, on: :create
  validates :profile, length: { maximum: 200 }, on: :update

  has_many :posts, dependent: :destroy
  has_many :user_answers, dependent: :destroy
  has_many :recommended_drummers, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post   # ユーザーがいいねした投稿を取得
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_drummers, through: :favorites, source: :drummer
  has_many :messages, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms
  has_many :diagnosis_results, dependent: :destroy

  enum role: { general: 0, admin: 1 }

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

  def favorite(drummer)
    favorite_drummers << drummer
  end

  def unfavorite(drummer)
    favorite_drummers.delete(drummer)
  end

  def favorite?(drummer)
    favorite_drummers.include?(drummer)
  end
end
