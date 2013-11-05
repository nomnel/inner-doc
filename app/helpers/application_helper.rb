module ApplicationHelper
  def link_to_add_user_fields text, f, usernames, options = {}
    fields = f.fields_for(:article_users, ArticleUser.new, child_index: 'new_article_users') do |g|
      render 'article_user_fields', f: g, usernames: usernames
    end
    link_to_function text, "add_user_fields(this, '#{escape_javascript(fields)}')", options
  end
end
