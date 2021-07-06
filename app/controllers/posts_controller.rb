class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @post = Post.new
    # 新しい投稿
    # @posts = Post.all
    # すべての投稿
    @posts = Post.page(params[:page]).reverse_order
    # Post.allでは1ページにすべて出てしまうので、「指定の数だけ。新しいもの順」に変更
    @all_ranks = Post.create_all_ranks
    # modelで作成した物を使用
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # ユーザーと投稿を紐づけ
     if @post.save
      redirect_to posts_path
     else
      @posts = Post.page(params[:page]).reverse_order
      render :index
     end
    # 情報を保存
  end

  def edit
    @post = Post.new
    # 新規作成用
    @post = Post.find(params[:id])
    # postモデルのデータベースから投稿データを取得
  end

  def update
    # post = Post.find(params[:id])
    # post.update(post_params)
    # if post.user == current_user
    #   redirect_to user_path(current_user.id)
    # else
    #   render "index"
    # end
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def show
    @post = Post.find(params[:id])
    # 主キーに対応するレコードを取り出す
    @post_comment = PostComment.new
    # 新しいコメント
  end

  def destroy
    @post = Post.find(params[:id])
    # 主キーに対応するレコードを取り出す
    @post.destroy
    redirect_to posts_path
  end



  private
  # 投稿データのストロングパラメータ
  def post_params
    params.require(:post).permit(:user_id, :title, :image, :body)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end
end
