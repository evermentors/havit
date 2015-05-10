# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

show_new_daily_goal_form = () ->
  $('.new-daily-goal-button').on 'click', (e) ->
    if($('.panel-body .new-daily-goal-form').hasClass('hidden'))
      $('.panel-body .new-daily-goal-form').removeClass('hidden')
    else
      $('.panel-body .new-daily-goal-form').addClass('hidden')

$(document).on 'ready page:load', show_new_daily_goal_form
