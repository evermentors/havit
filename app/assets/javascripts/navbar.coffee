show_mobile_menu = () ->
  $('.navigation-logo-mobile.signed-in > img').click () ->
    menu = $(this).next()
    if menu.hasClass('up')
      menu.slideDown(-> menu.toggleClass('up down'))
    else
      menu.slideUp(-> menu.toggleClass('up down'))

show_mobile_top_nav = () ->
  $('.group-and-goal-select').click () ->
    menu = $('.timeline-top-nav-on-mobile')
    if menu.hasClass('up')
      menu.slideDown(->
        menu.toggleClass('up down')
        $('.group-and-goal-select .show-button').toggleClass('fa-chevron-down fa-chevron-up')
      )
    else
      menu.slideUp(->
        menu.toggleClass('up down')
        $('.group-and-goal-select .show-button').toggleClass('fa-chevron-down fa-chevron-up')
      )

$(document).on 'ready page:load', show_mobile_menu
$(document).on 'ready page:load', show_mobile_top_nav
