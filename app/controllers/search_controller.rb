class SearchController < ApplicationController
  skip_before_action :require_login, only: [:index]
  skip_before_action :redirect_if_logged_in

  def index
    @q = Drummer.ransack(params[:q])
    @drummers = @q.result(distinct: true).includes(:artists, :genres).order(:name).page(params[:page])
  end
end
