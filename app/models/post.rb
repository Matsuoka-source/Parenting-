class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  # コメント機能との関係
  # has_many :favorites, dependent: :destroy
  # お気に入り機能との関係
  attachment :image
  # 画像アップ用のメソッド追加（refileのルール）
end
