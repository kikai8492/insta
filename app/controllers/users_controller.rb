class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash.now[:notice]= 'ユーザー登録が完了しました'
      redirect_to user_path(@user.id)
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
  end

  def edit
    @user=User.find(params[:id])
    if @user.id != current_user.id
      redirect_to blogs_path, notice: "他人の投稿及びプロフィールは編集できません！"
    end

  end
    

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), flash:{notice: "アカウント情報を更新しました!"}
    else
      flash.now[:danger] = 'アカウント情報の更新に失敗しました'
      render :edit
    end
  end


  def show
    @user = User.find(params[:id])

    
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:image, :image_cache)
  end
end
