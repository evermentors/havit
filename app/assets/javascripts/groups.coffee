is_join_available = () ->
  $('.group-join-btn > input').click (e) ->
    e.preventDefault()
    form = $(this).closest('form')
    passcode = $(this).parent().prev().find('input')
    $.ajax
      url: '/groups/' + $(this).attr('data-id') + '/can_join'
      data: { passcode: passcode.val()}
    .done () ->
      if passcode.hasClass('right-passcode')
        form.submit()

$(document).on 'ready page:load', is_join_available
