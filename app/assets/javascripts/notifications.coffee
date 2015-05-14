show_notifications = ()->
  $('.notification-btn').on 'click', (e) ->
    if $('.notifications-li').hasClass('closed')
      $.ajax(url: '/notifications').done () ->
        $('.notifications-count').addClass('hidden')
        $('.notification').slice(5).remove()
      $('.notifications-li').toggleClass('closed opened').focus()
      update_last_checked()
    else
      close_notifications()

close_notifications_on_blur = () ->
  $('.notifications-li').on 'blur', ->
    close_notifications()

move_to_notification_link = ()->
  $('body').on 'click', '.notification-link', ->
    group = $(this).attr('url')
    status = '?status-id=' + $(this).attr('status-id')
    window.location.href = group + status

close_notifications = () ->
  unless $('.notifications-li').hasClass('closed')
    $('.notifications-li').toggleClass('closed opened')

load_notifications = ()->
  $.ajax(url: '/notifications')

pull_unread = () ->
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

scroll_to_status = () ->
  if window.location.search.indexOf('status-id') > -1
    status_id = window.location.search.split('status-id=')[1]
    target = $('.card-container#status-card-'+status_id)
    $('html, body').animate({scrollTop: target.offset().top - 100}, 1000);

$(document).on 'ready page:load', show_notifications
$(document).on 'ready page:load', close_notifications_on_blur
$(document).on 'ready page:load', move_to_notification_link
$(document).on 'ready page:load', load_notifications
$(document).on 'ready page:load', pull_unread
$(document).on 'ready page:load', window.not_notified_yet = not_notified_yet
$(document).on 'ready page:load', scroll_to_status
