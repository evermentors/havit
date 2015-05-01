on_verified_at_changed = () ->
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
    datestr = (date.getMonth()+1) + '월 ' + date.getDate() + '일 목표'
    $('.status-footer .next-goal-date').text(datestr)
    $.ajax(url: '/daily_goals/' + $(this).val())

show_new_status_form = () ->
  $('.verify-past-btn').on 'click', (e) ->
    e.preventDefault()
    $('.notice-container').hide()
    $('.new-status-form-div').removeClass('hidden')
    $('.new-status-form-div textarea').autosize()

textarea_autosize = () ->
  $('textarea').each (index, element) =>
    $(element).autosize() unless $(element).closest('.new-status-form-div').hasClass('hidden')

toggle_monthly_weekly_goals = () ->
  $('.card-goals > .see-detail').on 'click', ->
    see_detail = $(this)
    if $(this).hasClass('up')
      $(this).prevAll('.goals-hidden').slideDown(-> see_detail.toggleClass('up down'))
    else
      $(this).prevAll('.goals-hidden').slideUp(-> see_detail.toggleClass('up down'))

apply_tooltip = () ->
  if !(window.matchMedia("(max-width: 767px)").matches)
    $('[data-toggle="tooltip"]').tooltip({container: 'body'})

show_uploaded_photo = () ->
  $('#status_photo').change () ->
    readURL(this)

readURL = (input) ->
  if input.files && input.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      $('.photo-preview').css('background-image', 'url(' + e.target.result + ')').removeClass('hidden')
    reader.readAsDataURL(input.files[0])

$(document).on 'ready page:load', on_verified_at_changed
$(document).on 'ready page:load', show_new_status_form
$(document).on 'ready page:load', textarea_autosize
$(document).on 'ready page:load', toggle_monthly_weekly_goals
$(document).on 'ready page:load', apply_tooltip
$(document).on 'ready page:load', show_uploaded_photo
