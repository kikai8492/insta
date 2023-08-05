class BlogsController < ApplicationController
  
  def index
    @blogs = Blog.all
    @users = current_user
  end

  def new
    @blog = Blog.new
  end

  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    user = current_user #confirmation_mailer.rbで使うために定義
    if @blog.save
      ConfirmationMailer.confirmation_email(user).deliver
      redirect_to blogs_path, notice: "投稿しました！"
    else
      render :new, notice: "投稿できませんでした"
    end
  end

  def show
    @blog = Blog.find(params[:id])
  end

  def edit
    @blog = current_user.blogs.find(params[:id])
    if @blog.user_id != current_user.id
      redirect_to blogs_path, notice: "他人の投稿は編集できません！"
    end
  end

  def update
    @blog = current_user.blogs.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "編集しました！"
    else
      render :edit, notice: "編集できませんでした"
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    if @blog.destroy
      redirect_to blogs_path, notice: "削除しました！"
    else
      render :index, notice: "削除できませんでした"
    end
  end

  private
  def blog_params
    params.require(:blog).permit(:content, :image, :image_cache)
  end
end
