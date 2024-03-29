require 'google/apis/youtube_v3'

class Drummer < ApplicationRecord
  validates :name, presence: true
  validates :country, presence: true

  enum country: {japan: 0, abroad: 1}

  has_many :drummer_genres, dependent: :destroy
  has_many :genres, through: :drummer_genres
  has_many :drummer_artists, dependent: :destroy
  has_many :artists, through: :drummer_artists
  has_many :songs, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :recommended_drummers, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[name country]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[drummer_genres genres drmmer_artists artists]
  end
end
