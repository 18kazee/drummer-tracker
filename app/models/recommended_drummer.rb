class RecommendedDrummer < ApplicationRecord
  belongs_to :user
  has_many :recommended_drummers_drummers, dependent: :destroy
  has_many :drummers, through: :recommended_drummers_drummers
end
