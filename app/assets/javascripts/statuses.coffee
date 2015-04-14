on_verified_at_changed = ()->
  $('.status-verified-at').on 'change', ->
    date = new Date($(this).val())
    date.setDate(date.getDate() + 1)
    datestr = (date.getMonth()+1) + '월 ' + date.getDate() + '일'
    $('.status-footer .next-goal-date').text(datestr)
    $.ajax(url: '/daily_goals/' + $(this).val())

textarea_autosize = ()->
  $('textarea').autosize()

$(document).on 'ready page:load', on_verified_at_changed
$(document).on 'ready page:load', textarea_autosize
