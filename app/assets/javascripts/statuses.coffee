on_verified_at_changed = ()->
  $('.status-verified-at').on 'change', ->
    date = new Date($(this).val())
    today = new Date()
    if date > today
      date = today
      $(this).val(today.toJSON().split('T')[0])
      $('.verify-tomorrow').removeClass('hidden')
    else
      $('.verify-tomorrow').addClass('hidden')
    date.setDate(date.getDate() + 1)
    datestr = (date.getMonth()+1) + '월 ' + date.getDate() + '일'
    $('.status-footer .next-goal-date').text(datestr)
    $.ajax(url: '/daily_goals/' + $(this).val())

show_new_status_form = () ->
  $('.verify-past-btn').on 'click', (e) ->
    e.preventDefault()
    $('.notice-container').hide()
    $('.new-status-form').removeClass('hidden')

textarea_autosize = ()->
  $('textarea').autosize()

$(document).on 'ready page:load', on_verified_at_changed
$(document).on 'ready page:load', show_new_status_form
$(document).on 'ready page:load', textarea_autosize
