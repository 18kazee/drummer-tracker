class PasswordResetsController < ApplicationController
  include PasswordResetHelper
  skip_before_action :redirect_if_logged_in
  skip_before_action :require_login, only: %i[create edit new]
  before_action :set_token, only: %i[edit update]
  before_action :set_user, only: %i[edit update]

  def new; end

  def create
    send_reset_link_to_email(params[:email])
    redirect_to login_path, success: t('.success')
  end

  def edit
    not_authenticated if @user.blank?
  end

  def update
    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      flash[:success] = t('.success')
      redirect_to login_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_token
    @token = params[:id]
  end

  def set_user
    @user = User.load_from_reset_password_token(@token)
  end
end
