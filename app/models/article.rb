class Article < ActiveRecord::Base
  has_many :article_users, dependent: :destroy
  has_many :users, through: :article_users
  accepts_nested_attributes_for :article_users,
                                allow_destroy: true,
                                reject_if: ->(attrs){attrs[:user_id].blank?}

  validates :title, presence: true
end
