class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books,dependent: :destroy
  has_many :book_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  #グループ機能実装
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :owned_groups, class_name: "Group"

  def follow(user_id)
  relationships.create(followed_id: user_id)
  end
  def unfollow(user_id)
  relationships.find_by(followed_id: user_id).destroy
  end
  def following?(user)
  followings.include?(user)
  end

  #検索方法の分岐
  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE?', content+'%')
    elsif method == 'backward'
      User.where('name LIKE?', '%'+content)
    else
      User.where('name LIKE?','%'+content+'%')
    end
  end

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  validates :introduction, length: {maximum: 50}

end
