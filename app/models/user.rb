class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :username, presence: true,
                       uniqueness: true
  validates :email,    presence: true,
                       uniqueness: true
  validates :password, confirmation: true,
                       presence: {on: :create}
end
