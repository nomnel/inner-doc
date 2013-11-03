class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :article_users, dependent: :destroy
  has_many :articles, through: :article_users

  validates :username, presence: true,
                       uniqueness: true
  validates :email,    presence: true,
                       uniqueness: true
  validates :password, confirmation: true,
                       presence: {on: :create}
end
