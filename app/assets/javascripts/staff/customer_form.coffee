$(document).on 'ready turbolinks:load', ->
  $('#enable-password-field').on 'click', ->
    $('#enable-password-field').hide()
    $('#disable-password-field').show()
    $('#form_customer_password').removeAttr('disabled')
    $('label[for=form_customer_password]').addClass('required')
  $('#disable-password-field').on 'click', ->
    $('#disable-password-field').hide()
    $('#enable-password-field').show()
    $('#form_customer_password').attr('disabled', 'disabled')
    $('label[for=form_customer_password]').removeClass('required')

  $('input#form_inputs_home_address').on 'click', ->
    toggle_home_address_fields()
  $('input#form_inputs_work_address').on 'click', ->
    toggle_work_address_fields()

  toggle_home_address_fields = ->
    checked = $('input#form_inputs_home_address').prop('checked')
    $('fieldset#home_address_fields input').prop('disabled', !checked)
    $('fieldset#home_address_fields select').prop('disabled', !checked)
    $('#home_address_fields').toggle(checked)

  toggle_work_address_fields = ->
    checked = $('input#form_inputs_work_address').prop('checked')
    $('fieldset#work_address_fields input').prop('disabled', !checked)
    $('fieldset#work_address_fields select').prop('disabled', !checked)
    $('#work_address_fields').toggle(checked)

  toggle_home_address_fields()
  toggle_work_address_fields()
