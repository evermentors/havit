show_navigation_on_mobile = () ->
  $('button.navbar-toggle').click (e) ->
    $('body').toggleClass('side-open')
    $(this).toggleClass('opened')

$(document).on 'ready page:load', show_navigation_on_mobile
