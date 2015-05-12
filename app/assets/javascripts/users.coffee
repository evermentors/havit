show_name_input_on_edit_account = () ->
  $('.authform.account-update .user-name').click ->
    $(this).parent().addClass('editing')

show_uploaded_profile = () ->
  $('input#user_avatar').change () ->
    read_profile(this)

read_profile = (input) ->
  if input.files && input.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      $('.profile-photo-link > .show-profile > img').attr('src', e.target.result)
    reader.readAsDataURL(input.files[0])

$(document).on 'ready page:load', show_name_input_on_edit_account
$(document).on 'ready page:load', show_uploaded_profile
$(document).on 'ready page:load', read_profile
