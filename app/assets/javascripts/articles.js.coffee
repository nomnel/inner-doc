window.remove_user_fields = (link) ->
  $(link).prev('input[type=hidden]').val('true')
  $(link).closest('.fields').hide()

window.add_user_fields = (link, content) ->
  new_id = new Date().getTime()
  regexp = new RegExp('new_article_users', 'g')
  $(link).prev().append(content.replace regexp, new_id)
