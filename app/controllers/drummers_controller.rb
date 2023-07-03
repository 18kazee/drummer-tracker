class DrummersController < ApplicationController
  skip_before_action :require_login, only: [:index, :show, :search]
  
  def index
    @drummers = Drummer.all.order(:name).page(params[:page])
  end

  def search
    @q = Drummer.ransack(params[:q])
    @drummers = @q.result(distinct: true).order(:name).page(params[:page])
  end

  def show
    @drummer = Drummer.find(params[:id])
  end

  private

  def drummer_params
    params.require(:drummer).permit(:name)
  end
end
