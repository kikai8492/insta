class FavoritesController < ApplicationController
  def create
    @blog = Blog.find(params[:blog])
    if @blog.user_id != current_user.id #自分の投稿にはいいねできないようにする
      @favorite = Favorite.create(user_id: current_user.id, blog_id: @blog.id) #いいねを押したらその投稿のidを取得して、@favoriteに代入
      redirect_to blogs_path, notice: "いいねしました"
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @favorite = Favorite.find_by(user_id: current_user.id, blog_id: @blog.id)
    @favorite.destroy
    redirect_to blogs_path, notice: "いいねを取り消しました"

  end

  def show
    favorites = Favorite.where(user_id: current_user.id).pluck(:blog_id)
    @favorite_list = Blog.find(favorites)
  end
end