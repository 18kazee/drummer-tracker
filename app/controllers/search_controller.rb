class SearchController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @q = Drummer.ransack(params[:q])
    @drummers = @q.result(distinct: true).includes(:artists, :genres).order(:name).page(params[:page])
  end
end
