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

  def search_youtube_videos
    youtube_service = Google::Apis::YoutubeV3::YouTubeService.new
    youtube_service.key = ENV['YOUTUBE_API_KEY']

    drummer_name = name
    artist_names = artists.pluck(:name)
    # ドラマーの名前でYouTube検索を行う
     query_with_artists = "#{drummer_name} ドラム #{artist_names.join(' ')}"
     search_response_with_artists = youtube_service.list_searches('snippet', q: query_with_artists, max_results: 4, type: 'video')

    if search_response_with_artists.items.empty?
    # 検索結果が見つからない場合、ドラマー名のみを含むクエリで再度検索
      query_without_artists = "#{drummer_name} ドラム"
      search_response_without_artists = youtube_service.list_searches('snippet', q: query_without_artists, max_results: 3, type: 'video')
      search_response = search_response_without_artists
    else
      search_response = search_response_with_artists
    end

    youtube_videos = search_response.items.map do |item|
      item.id.video_id
    end
    # データベースに保存
    update_attribute(:youtube_videos, youtube_videos)
  end
end
