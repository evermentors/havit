set_invite_email = ()->
  $(".send-invite").on "click", (e) ->
    address = "mailto:" + $("#address").val()
    subject = "?subject=" + "해빗에 초대합니다"
    message = "&body=" + $("#message").val()
    message += "%0D%0A%0D%0A가입하시려면 이 링크를 누르세요.%0D%0A%0D%0Ahttp://havit.kr/users/sign_up/axsdcfvfg"
    $(this).attr("href", address + subject + message)

$(document).ready set_invite_email
$(document).on 'page:load', set_invite_email
