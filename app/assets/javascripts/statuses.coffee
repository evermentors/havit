on_verified_at_changed = () ->
  $('.status-dates li').click ->
    unless $(this).hasClass('active')
      goal_date = $(this).attr('goal-date')

      $('.status-dates li.active').removeClass('active first-load')
      $(this).addClass('active')
      $('.status-verified-at').val(goal_date)

      week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일')
      date = new Date(goal_date)
      date_selected_str = (date.getFullYear()) + '년 ' + (date.getMonth()+1) + '월 ' + date.getDate() + '일 ' + week[date.getDay()]
      $('.status-goal > .goal-date').text(date_selected_str)

      date.setDate(date.getDate() + 1)
      next_goal_date_str = (date.getMonth()+1) + '월 ' + date.getDate() + '일 목표:'
      $('.next-goal-date').text(next_goal_date_str)

      $.ajax(url: '/daily_goals/' + goal_date)

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
  $('body').on 'click', '.card-goals > .see-detail', ->
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

bigger_photo_when_clicked = () ->
  $('.card-photo > img').click () ->
    status = $(this).closest('.card-container').clone().toggleClass('card-container container-center modal-status')
    $('.photo-modal .modal-body').html(status)
    $('.photo-modal .comment_actions > a').tooltip({container: 'body'})
    new_comment_link = $('.photo-modal .thread_new_comment_link > a').attr('href') + '?modal=.photo-modal'
    $('.photo-modal .thread_new_comment_link > a').attr('href', new_comment_link)
    $('.photo-modal').modal()

$(document).on 'ready page:load', on_verified_at_changed
$(document).on 'ready page:load', show_new_status_form
$(document).on 'ready page:load', textarea_autosize
$(document).on 'ready page:load', toggle_monthly_weekly_goals
$(document).on 'ready page:load', apply_tooltip
$(document).on 'ready page:load', show_uploaded_photo
$(document).on 'ready page:load', bigger_photo_when_clicked
