is_join_available = () ->
  $('.group-join-btn > input').click (e) ->
    e.preventDefault()
    $.ajax(url: '/groups/' + $(this).attr('data-id') + '/can_join')

$(document).on 'ready page:load', is_join_available
