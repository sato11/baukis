$(document).on 'ready turbolinks:load', ->
  $('#enable-password-field').on 'click', ->
    $('#enable-password-field').hide()
    $('#disable-password-field').show()
    $('#staff_member_password').removeAttr('disabled')
    $('label[for=staff_member_password]').addClass('required')
  $('#disable-password-field').on 'click', ->
    $('#disable-password-field').hide()
    $('#enable-password-field').show()
    $('#staff_member_password').attr('disabled', 'disabled')
    $('label[for=staff_member_password]').removeClass('required')
