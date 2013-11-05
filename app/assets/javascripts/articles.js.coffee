window.add_user_fields = (link, content) ->
  new_id = new Date().getTime()
  regexp = new RegExp('new_article_users', 'g')
  $(link).prev().append(content.replace regexp, new_id)

$(document).on 'click', '.remove-user', ->
  $(this).prev('input[type=hidden]').val('true')
  $(this).closest('.fields').hide()
  false