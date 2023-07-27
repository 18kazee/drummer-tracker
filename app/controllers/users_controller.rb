class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :activate, :resend_activation_form, :resend_activation] 

  # User Registration
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # If user is saved successfully than show message
    if @user.save
      @user.send_activation_needed_email
      render :new, success: '登録用のメールを送信しました。メールをご確認ください。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      redirect_to login_path, success: '会員登録が完了しました。'
    else
      not_authenticated
    end
  end

  def resend_activation_form; end
  
 def resend_activation
   user = User.find_by(email: params[:email])
     if user
       # activation_stateが'active'でない場合のみ再送信
       unless user.activation_state == 'active'
         user.resend_activation_email
         flash[:success] = '確認メールを再送信しました。'
       else
         flash[:success] = '確認メールを再送信しました。'
       end
     else
       flash[:success] = '確認メールを再送信しました。'
     end
     redirect_to new_user_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :salt)
  end
end
