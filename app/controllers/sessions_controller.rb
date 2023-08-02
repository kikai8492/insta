class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create, :show]
  def new
    
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id]=@user.id
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = 'ログインに失敗しました。メールアドレスもしくはパスワードが違います。'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end

   private
   def user_params
     params.require(:user).permit(:name, :email, :password, :password_confirmation,:image, :image_cache)
   end
end
