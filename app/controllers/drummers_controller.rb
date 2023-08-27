class DrummersController < ApplicationController
  skip_before_action :require_login, only: [:index, :show, :modal, :autocomplete]
  skip_before_action :redirect_if_logged_in

  def index
    @drummers = Drummer.includes(:artists, :genres).order(:name).page(params[:page])
  end
  
  def show
    @drummer = Drummer.includes(:artists, :genres).find(params[:id])
    @artists = @drummer.artists
  end

  def modal
    @drummer = Drummer.find(params[:id])
  end

  def autocomplete
    query = params[:q]
    @drummers = Drummer.where("name ILIKE ?", "%#{query}%")
    render partial: 'drummers/autocomplete_results', locals: { drummers: @drummers }
  end

  def favorites
    @favorite_drummers = current_user.favorite_drummers.includes(:user, :artists, :genres).order(created_at: :desc).page(params[:page])
  end
end
