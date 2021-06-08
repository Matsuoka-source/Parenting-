class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  # コメント機能との関係
  has_many :favorites, dependent: :destroy
  # お気に入り機能との関係
  attachment :image
  # 画像アップ用のメソッド追加（refileのルール）

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
    #このメソッドで、引数で渡されたユーザidがFavoritesテーブル内に存在するか確認
  end

end
