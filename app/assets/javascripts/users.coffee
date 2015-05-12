show_name_input_on_edit_account = () ->
  $('.authform.account-update .user-name').click ->
    $(this).parent().addClass('editing')

$(document).on 'ready page:load', show_name_input_on_edit_account
