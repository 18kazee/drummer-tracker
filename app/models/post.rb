class Post < ApplicationRecord
  belongs_to :user
  belongs_to :drummer

  validates :tweet, presence: true, length: { maximum: 140 }
  validates :drummer_id, presence: true
  validates :user_id, presence: true
end
