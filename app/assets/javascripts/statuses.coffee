on_verified_at_changed = () ->
  $('.status-dates li').click ->
    unless $(this).hasClass('active')
      action_date = $(this).attr('action-date')

      $('.status-dates li.active').removeClass('active first-load')
      $(this).addClass('active')
      $('.status-verified-at').val(action_date)

      $.ajax(url: window.location.pathname + "/" + action_date)

show_new_status_form = () ->
  $('body').on 'click', '.want-more-verification > .btn', (e) ->
    e.preventDefault()
    $(this).parent().hide()
    $(this).parent().prev().addClass('hidden')
    $(this).parent().next().removeClass('hidden')
    $(this).parent().next().find("textarea").autosize()

textarea_autosize = () ->
  $('textarea').each (index, element) =>
    $(element).autosize() unless $(element).closest('.new-status-form-div').hasClass('hidden')

apply_tooltip = () ->
  if !(window.matchMedia("(max-width: 767px)").matches)
    $('[data-toggle="tooltip"]').tooltip({container: 'body'})

show_uploaded_photo = () ->
  $('#status_photo').change () ->
    readURL(this)

remove_uploaded_photo = () ->
  $('.photo-preview > .photo-remove-btn').click () ->
    control = $("#status_photo")
    control.replaceWith( control.val('').clone( true ) )
    $('.photo-preview').css('background-image', '').addClass('hidden')

readURL = (input) ->
  if input.files && input.files[0]
    reader = new FileReader()
    reader.onload = (e) ->
      if input.files[0].type == "image/jpeg"
        exif = piexif.load(e.target.result)
        orientation = exif["0th"][piexif.ImageIFD.Orientation]
        if orientation == 6
          $('.photo-preview').addClass('photo-preview-transform-90')
        else if orientation == 7
          $('.photo-preview').addClass('photo-preview-transform-180')
        else if orientation == 8
          $('.photo-preview').addClass('photo-preview-transform-270')
      $('.photo-preview').css('background-image', 'url(' + e.target.result + ')').removeClass('hidden')
    reader.readAsDataURL(input.files[0])

bigger_photo_when_clicked = () ->
  $('.card-photo > img').click () ->
    status = $(this).closest('.card-container').clone().toggleClass('card-container modal-status')
    $('.photo-modal .modal-body').html(status)
    $('.photo-modal .comment_actions > a').tooltip({container: 'body'})
    new_comment_link = $('.photo-modal .thread_new_comment_link > a').attr('href') + '?modal=.photo-modal'
    $('.photo-modal .thread_new_comment_link > a').attr('href', new_comment_link)
    $('.photo-modal').modal()

show_status_textarea = () ->
  $('.modify-status-link').click ->
    $('.card-container').removeClass('editing')
    target = $(this).closest('.card-container').addClass('editing')

    # 텍스트에어리어 맨 끝으로 포커스되게 함
    textarea = target.find('.status-textarea')
    # replace로 쓸데없이 생기는 leading spaces를 없앰
    original_val = textarea.val()
    textarea.focus().val('').val(original_val).trigger('autosize.resize')

cancel_edit_status = () ->
  $('.card-container .btn-cancel').click ->
    $(this).closest('.card-container').removeClass('editing')

show_progress_bar_on_new_status_form = () ->
  $('.new-status-form button[type=submit]').click ->
    NProgress.start()

$(document).on 'ready page:load', on_verified_at_changed
$(document).on 'ready page:load', show_new_status_form
$(document).on 'ready page:load', textarea_autosize
$(document).on 'ready page:load', apply_tooltip
$(document).on 'ready page:load', show_uploaded_photo
$(document).on 'ready page:load', remove_uploaded_photo
$(document).on 'ready page:load', bigger_photo_when_clicked
$(document).on 'ready page:load', show_status_textarea
$(document).on 'ready page:load', cancel_edit_status
# $(document).on 'ready page:load', show_progress_bar_on_new_status_form
