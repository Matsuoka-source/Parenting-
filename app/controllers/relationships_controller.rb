class RelationshipsController < ApplicationController
  # フォロー機能を作成・保存・削除(userモデルで定義したfollow,unfollowメソッドを使用)
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
    # 遷移前のURLを取得
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  # フォロー・フォロワー一覧の表示
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
    # これでフォローしているユーザid一覧を取得
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
    # これでフォローされているユーザid一覧を取得
  end


end
