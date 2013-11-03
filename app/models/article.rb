class Article < ActiveRecord::Base
  has_many :article_users, dependent: :destroy
  has_many :users, through: :article_users

  validates :title, presence: true
end
