class Artist < ApplicationRecord
  has_many :drummer_artists
  has_many :drummers, through: :drummer_artists

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
