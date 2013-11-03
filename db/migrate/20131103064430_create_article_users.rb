class CreateArticleUsers < ActiveRecord::Migration
  def change
    create_table :article_users do |t|
      t.references :article, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
