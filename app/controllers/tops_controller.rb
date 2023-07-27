class TopsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  skip_before_action :redirect_if_logged_in

  def index; end
end
