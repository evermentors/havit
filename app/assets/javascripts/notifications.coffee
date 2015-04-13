show_notifications = ()->
  $('.notification-btn').on 'click', ->
    if $('.notifications-container').hasClass('closed')
      $.ajax(url: '/notifications').done () ->
        $('.notifications-count').addClass('hidden')
        $('.notification').slice(5).remove()
    else
      update_last_checked()

    $('.notifications-container').toggleClass('closed opened')
    $('.notification-btn').toggleClass('closed opened')

scroll_to_status = ()->
  $('body').on 'click', '.notification-link', ->
    status_url = $(this).attr('status-url').split('/')
    status_id = status_url[status_url.length - 1]
    target = $('.card-container#status-card-'+status_id)
    $('html, body').animate({scrollTop: target.offset().top - 100}, 1000);

    $('.notifications-container').toggleClass('closed opened')
    $('.notification-btn').toggleClass('closed opened')
    update_last_checked()

load_notifications = ()->
  $.ajax(url: '/notifications')

pull_unread = () ->
  # $('.temp').on 'click', ->
  setInterval () ->
    $.ajax(url: '/notifications/pull_unread')
  , 60000

update_last_checked = () ->
  last_checked = parseInt($(".notification:first").attr('notification-id'))
  if parseInt($('.notification-btn').attr('last-checked')) < last_checked
    $('.notification-btn').attr('last-checked', last_checked)
    $.ajax(url: '/notifications/'+ last_checked + '/read')

not_notified_yet = (noti_id) ->
  noti_arr = []
  $('.notification').each (index, element) =>
    noti_arr.push $(element).attr('notification-id')
  if noti_id in noti_arr
    return false
  else
    return true

$(document).on 'ready page:load', show_notifications
$(document).on 'ready page:load', scroll_to_status
$(document).on 'ready page:load', load_notifications
$(document).on 'ready page:load', pull_unread
$(document).on 'ready page:load', window.not_notified_yet = not_notified_yet
