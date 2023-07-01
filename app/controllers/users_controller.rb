class UsersController < ApplicationController

  # User Registration
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    # If user is saved successfully than show message
    if @user.save
      flash[:notice] = 'User created successfully!'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
