class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  # コメント機能との関係
  has_many :favorites, dependent: :destroy
  # お気に入り機能との関係
  attachment :image
  # 画像アップ用のメソッド追加（refileのルール）
  validates :title, presence: true
  validates :body, presence: true
  # バリデーション　上記のカラムが入っていないと戻る
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
    #このメソッドで、引数で渡されたユーザidがFavoritesテーブル内に存在するか確認
  end

  def self.create_all_ranks #postクラスからデータを取ってくる処理なので暮らすメソッド
    Post.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
    # favorite.group(:post_id)      投稿の番号が同じものになるグループを分ける
    # order('count(post_id) desc')  番号の多い順に並べ替える
    # limit(3)                      表示する物の数
    # pluck(:post_id)               post_idカラムのみを数字で取り出す

    # Post.find()                   pluckで取り出される数字をpost_idにすることでいいね順にpostを取得できる
  end

end
