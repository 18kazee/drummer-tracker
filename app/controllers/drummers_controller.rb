class DrummersController < ApplicationController
  skip_before_action :require_login, only: [:index, :show, :modal, :autocomplete]

  require 'rspotify'
  RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])

  def index
    @drummers = Drummer.includes(:artists, :genres).order(:name).page(params[:page])
  end
  
  def show
    @drummer = Drummer.includes(:artists, :genres).find(params[:id])
    @search_artists = []
    @drummer_artists = []
    @drummer.artists.each do |artist|
      result = RSpotify::Artist.search(artist.name)
      search_artists = result[0..1]
      search_artists.each do |search_artist|
        search_artist.name.downcase!
        @search_artists << search_artist
      end
      @drummer_artists << artist.spotify_name
    end
    @search_artists.sort_by! { |search_artist| -search_artist.followers['total'] }
    @search_artists.uniq!(&:name)
  end

  def modal
    @drummer = Drummer.find(params[:id])
  end

  def autocomplete
    query = params[:q]
    puts "Query: #{query}" # ログ出力
    @drummers = Drummer.where("name ILIKE ?", "%#{query}%")
    render partial: 'drummers/autocomplete_results', locals: { drummers: @drummers }
  end
end
