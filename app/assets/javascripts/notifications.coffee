show_notifications = ()->
  $('.notification-btn').on 'click', ->
    if $('.notifications-container').hasClass('closed')
      if $('.notification').length == 0
        $.ajax(url: '/notifications')
    $('.notifications-container').toggleClass('closed opened')
    $('.notification-btn').toggleClass('closed opened')

scroll_to_status = ()->
  $('body').on 'click', '.notification-link', ->
    status_url = $(this).attr('status-url').split('/')
    status_id = status_url[status_url.length - 1]
    target = $('.card-container#status-card-'+status_id)
    $('html, body').animate({scrollTop: target.offset().top - 100}, 1000);

$(document).on 'ready page:load', show_notifications
$(document).on 'ready page:load', scroll_to_status
