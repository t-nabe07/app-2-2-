class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users
  #belongs_to :user
  attachment :image, destroy: false
  validates :introduction, presence: true
  validates :name, presence: true, uniqueness: true
end
