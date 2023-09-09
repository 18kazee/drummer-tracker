class RecommendedDrummer < ApplicationRecord
  belongs_to :user
  belongs_to :drummer
end
