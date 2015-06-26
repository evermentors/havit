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
        $('body').addClass('no-scroll')
        menu.focus()
      )
    else
      close_mobile_top_nav()

close_mobile_top_nav = () ->
  menu = $('.timeline-top-nav-on-mobile')
  if menu.hasClass('down')
    menu.slideUp(->
      menu.toggleClass('up down')
      $('.group-and-goal-select .show-button').toggleClass('fa-angle-down fa-angle-up')
      $('body').removeClass('no-scroll')
    )

close_mobile_top_nav_on_blur = () ->
  $('.timeline-top-nav-on-mobile').blur () ->
    close_mobile_top_nav()

$(document).on 'ready page:load', show_mobile_menu
$(document).on 'ready page:load', show_mobile_top_nav
# $(document).on 'ready page:load', close_mobile_top_nav_on_blur
