show_goal_textarea = () ->
  $('.modify-goal-link').click ->
    target = $(this).closest('.goal-container').addClass('editing')

    # 텍스트에어리어 맨 끝으로 포커스되게 함
    textarea = target.find('.goal-textarea')
    # replace로 쓸데없이 생기는 leading spaces를 없앰
    original_val = target.find('.goal-description').text().replace(/[ \t]{2,}/g, "");
    textarea.focus().val('').val(original_val).trigger('autosize.resize')

cancel_edit_goal = () ->
  $('.goal-container .modify-actions .btn-cancel').click ->
    target = $(this).closest('.goal-container').removeClass('editing')

edit_goal_on_new_status_form = () ->
  $('.new-status-form .btn-confirm').click ->
    target = $(this).closest('.goal-container')
    goal_date = target.find('.status-verified-at').val()
    goal_description = target.find('.goal-textarea').val()
    $.ajax({
      method: 'PATCH',
      url: '/daily_goals/' + $(this).attr('data-id'),
      data: {
        daily_goal: {
          description: goal_description,
          goal_date: goal_date
        }
      }
    })

$(document).on 'ready page:load', show_goal_textarea
$(document).on 'ready page:load', cancel_edit_goal
$(document).on 'ready page:load', edit_goal_on_new_status_form
