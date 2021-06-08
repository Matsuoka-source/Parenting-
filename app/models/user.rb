class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  # 投稿との関係
  has_many :post_comments, dependent: :destroy
  #投稿へのコメントとの関係
  has_many :favorites, dependent: :destroy
end
