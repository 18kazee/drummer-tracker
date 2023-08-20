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
  has_many :recommended_drummersdrummers, dependent: :destroy
  has_many :recommended_drummers, through: :recommended_drummersdrummers

  def self.ransackable_attributes(auth_object = nil)
    %w[name country]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[drummer_genres genres drmmer_artists artists]
  end

  def self.update_discogs_id
    drummers = Drummer.all
    drummers.each_slice(25) do |batch|
      batch.each do |drummer|
        auth_wrapper = Discogs::Wrapper.new("My awesome web app", user_token: ENV['DISCOGS_USER_TOKEN'])
        search = auth_wrapper.search(drummer.name, per_page: 10, type: :artist)
        if search.results.present? && search.results[0].id
          discogs_id = search.results[0].id
          drummer.update(discogs_id:)
          Rails.logger.debug "success update discogs_id #{drummer.name}"
        else
          drummer.update(discogs_id: nil)
          Rails.logger.debug "failed update discogs_id #{drummer.name}"
        end
      end
      sleep(60)
    end
  end
end
