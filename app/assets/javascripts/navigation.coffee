show_navigation_on_mobile = () ->
  $('button.navbar-toggle').click (e) ->
    $('body').toggleClass('side-open')
    $(this).toggleClass('opened')

close_navigation_on_mobile = () ->
  $('.overlay').click (e) ->
    $('body').toggleClass('side-open')
    $('button.navbar-toggle').toggleClass('opened')

fix_fixed_on_touch = () ->
  if /iPhone|iPod|Android|iPad/.test(window.navigator.platform)
    $(document).on 'focus', 'textarea,input,select', () ->
      $('.navbar.navbar-fixed-top').css('position', 'absolute')
      $('.side-nav').css('position', 'absolute')
      $('.uv-icon').hide()
    $(document).on 'blur', 'textarea,input,select', () ->
      $('.navbar.navbar-fixed-top').css('position', '')
      $('.side-nav').css('position', '')
      $('.uv-icon').show()

$(document).on 'ready page:load', show_navigation_on_mobile
$(document).on 'ready page:load', close_navigation_on_mobile
$(document).on 'ready page:load', fix_fixed_on_touch
