class Drummer < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :country, presence: true
  validates :profile, presence: true

  enum country: {japan: 0, abroad: 1}

  has_many :drummer_genres
  has_many :genres, through: :drummer_genres
  has_many :drummer_artists
  has_many :artists, through: :drummer_artists

  def self.ransackable_attributes(auth_object = nil)
    %w[name country]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[drummer_genres genres drmmer_artists artists]
  end
end
