class FavoritesController < ApplicationController

  def create
    @drummer = Drummer.find(params[:drummer_id])
    current_user.favorite(@drummer)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @drummer = current_user.favorites.find_by(id: params[:id]).drummer
    current_user.unfavorite(@drummer)
    respond_to do |format|
      format.turbo_stream
    end
  end
end
