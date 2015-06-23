show_mobile_menu = () ->
  $('.navigation-logo-mobile.signed-in > img').click () ->
    menu = $(this).next()
    if menu.hasClass('up')
      menu.slideDown(-> menu.toggleClass('up down'))
    else
      menu.slideUp(-> menu.toggleClass('up down'))

toggle_monthly_weekly_goals = () ->
  $('body').on 'click', '.card-goals > .see-detail', ->
    see_detail = $(this)
    if $(this).hasClass('up')
      $(this).prevAll('.goals-hidden').slideDown(-> see_detail.toggleClass('up down'))
    else
      $(this).prevAll('.goals-hidden').slideUp(-> see_detail.toggleClass('up down'))

$(document).on 'ready page:load', show_mobile_menu
