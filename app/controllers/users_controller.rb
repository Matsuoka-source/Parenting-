class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post_images = @user.posts.page(params[:page]).reverse_order
    # すべての投稿画像が表示されないように設定し、全体の投稿ではなく、個人が投稿した物のみ
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)

  end

  def index
    @user = current_user
    @users = User.all
    @post = Post.new
    @posts = Post.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :image)
  end
end
