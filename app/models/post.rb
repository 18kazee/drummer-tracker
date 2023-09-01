class Post < ApplicationRecord
  belongs_to :user
  belongs_to :drummer
  belongs_to :room
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :room_id, presence: true
  validates :tweet, presence: true, length: { maximum: 140 }
  validates :drummer_id, presence: true
  validates :user_id, presence: true

  def relative_time_since_created
    distance_of_time_in_words_to_now(created_at)
  end
end
