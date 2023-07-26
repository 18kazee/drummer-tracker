class Artist < ApplicationRecord
  has_many :drummer_artists, dependent: :destroy
  has_many :drummers, through: :drummer_artists

  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "data_name", "name", "updated_at"]
  end
end
