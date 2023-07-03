class Genre < ApplicationRecord
  has_many :drummer_genres
  has_many :drummers, through: :drummer_genres

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id name updated_at]
  end
end
