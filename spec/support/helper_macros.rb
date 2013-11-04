module HelperMacros
  def article_editable_by_user article, user
    article.users << user
    article.save
    article
  end
end