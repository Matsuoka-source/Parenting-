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
  attachment :image
  # refileを使用するため記述

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # Relationshipにuser_idカラムはないため、foreign_keyでどのカラムを参照するか定義。見分けやすいようにreverseと定義
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # throughを経由してuserテーブルを参照する  followed_idをフォローしている人

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  # throughを経由してuserテーブルを参照する  follower_idをフォローしている人

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def followings?(user)
    followings.include?(user)
  end

  # いいね機能と同様


end
