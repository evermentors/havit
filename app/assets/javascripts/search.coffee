hide_joined_or_all = ()->
  $('.search-results > .menus > button').click ->
    $(this).siblings('.active').removeClass('active')
    $(this).addClass('active')
    $('.search-results').removeClass('show-all show-not-joined').addClass($(this).attr('trigger'))

$(document).on 'ready page:load', hide_joined_or_all
