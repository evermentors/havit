show_navigation_on_mobile = () ->
  $('button.navbar-toggle').click (e) ->
    $('body').toggleClass('side-open')
    $(this).toggleClass('opened')

close_navigation_on_mobile = () ->
  $('.overlay').click (e) ->
    $('body').toggleClass('side-open')
    $('button.navbar-toggle').toggleClass('opened')

$(document).on 'ready page:load', show_navigation_on_mobile
$(document).on 'ready page:load', close_navigation_on_mobile
