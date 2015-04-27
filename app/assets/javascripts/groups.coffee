is_join_available = () ->
  $('.group-join-btn > input').click (e) ->
    e.preventDefault()
    form = $(this).closest('form')
    passcode = form.find('.passcode-input')
    $.ajax
      url: '/groups/' + $(this).attr('data-id') + '/can_join'
      data: { passcode: passcode.val()}
    .done () ->
      if passcode.hasClass('right-passcode')
        form.submit()

tooltip_on_join_error = () ->
  $('.management.full-group').tooltip({container: 'body', title: '그룹이 가득 찼습니다.'})

$(document).on 'ready page:load', is_join_available
$(document).on 'ready page:load', tooltip_on_join_error
