show_notifications = ()->
  $('.notification-btn').on 'click', ->
    if $('.notifications-container').hasClass('closed')
      if $('.notification').length == 0
        $.ajax(url: '/notifications')
    $('.notifications-container').toggleClass('closed opened')
    $('.notification-btn').toggleClass('closed opened')

$(document).on 'ready page:load', show_notifications
