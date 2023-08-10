class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :redirect_if_logged_in
  add_flash_types :success, :info, :warning, :danger

  private

  def not_authenticated
    redirect_to login_path, danger: t('defaults.message.require_login')
  end

  def redirect_if_logged_in
    if logged_in?
      redirect_to root_path, success: 'ログインしています'
    end
  end
end
