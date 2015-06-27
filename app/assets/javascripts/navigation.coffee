show_mobile_right_menu = () ->
  $('.show-on-mobile .more-btn').click () ->
    $('body').toggleClass('side-open right')

show_mobile_left_menu = () ->
  $('.navigation-btn-mobile').click () ->
    if $('.navigation-btn-mobile > .glyphicon').hasClass('glyphicon-menu-right')
      $('body').toggleClass('side-open left')
      $('.navigation-btn-mobile > .glyphicon').toggleClass('glyphicon-menu-right glyphicon-menu-left')

close_navigation_on_mobile = () ->
  $('.overlay').click (e) ->
    if $('body').hasClass('left')
      $('.navigation-btn-mobile > .glyphicon').removeClass('glyphicon-menu-left').addClass('glyphicon-menu-right')
    $('body').removeClass('side-open left right')

fix_goal_name_on_header_when_scroll = () ->
  if (window.matchMedia("(max-width: 767px)").matches)
    $(window).on 'scroll', () ->
      if $(this).scrollTop() > ($('.card-container:first').offset().top - 40)
        $(".goal-info .goal-description > .theme").addClass("fixed")
        $(".goal-info .goal-description > .detail").addClass('fixed')
      else
        $(".goal-info .goal-description > .theme").removeClass("fixed")
        $(".goal-info .goal-description > .detail").removeClass('fixed')

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

$(document).on 'ready page:load', show_mobile_right_menu
$(document).on 'ready page:load', show_mobile_left_menu
$(document).on 'ready page:load', close_navigation_on_mobile
$(document).on 'ready page:load', fix_goal_name_on_header_when_scroll
$(document).on 'ready page:load', fix_fixed_on_touch
