class DrummersController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  require 'rspotify'
  # SpotifyのAPIキーを認証
   RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])

  def index
    @drummers = Drummer.all.order(:name).page(params[:page])
  end

  def show
    @drummer = Drummer.find(params[:id])
    @search_artists = []
    @drummer_artists = []
    # ドラマーに関連するアーティスト名を取得
    @drummer.artists.each do |artist|
      @drummer_artists << artist.spotify_name
      result = RSpotify::Artist.search(artist.name)
      search_artists = result[0..1]
      search_artists.each do |search_artist|
        search_artist.name.downcase!
        @search_artists << search_artist
      end
    end
    @search_artists.sort_by! { |search_artist| -search_artist.followers['total'] }
    @search_artists.uniq!(&:name)

  end
end
