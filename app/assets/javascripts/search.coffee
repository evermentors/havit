hide_joined_or_all = ()->
  $('.search-results > .menus > button').click ->
    $(this).siblings('.active').removeClass('active')
    $(this).addClass('active')
    $('.search-results').removeClass('show-all show-not-joined').addClass($(this).attr('trigger'))

show_progress_bar_on_search = () ->
  $('.search-form button[type=submit]').click ->
    NProgress.start()

$(document).on 'ready page:load', hide_joined_or_all
$(document).on 'ready page:load', show_progress_bar_on_search
$(document).on 'page:receive', NProgress.set(0.7)
