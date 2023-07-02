class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create] 

  # User Registration
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # If user is saved successfully than show message
    if @user.save
      redirect_to root_path, success: t('.success')
    else
      render :new, status: :unprocessable_entity 
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :salt)
  end
end
