show_mobile_menu = () ->
  $('.show-on-mobile .more-btn').click () ->
    $('body').toggleClass('side-open')

show_mobile_top_nav = () ->
  $('.group-and-goal-select').click () ->
    menu = $('.timeline-top-nav-on-mobile')
    if menu.hasClass('up')
      menu.slideDown(->
        menu.toggleClass('up down')
        $('.group-and-goal-select .show-button').toggleClass('fa-angle-down fa-angle-up')
      )
    else
      menu.slideUp(->
        menu.toggleClass('up down')
        $('.group-and-goal-select .show-button').toggleClass('fa-angle-down fa-angle-up')
      )

$(document).on 'ready page:load', show_mobile_menu
$(document).on 'ready page:load', show_mobile_top_nav
