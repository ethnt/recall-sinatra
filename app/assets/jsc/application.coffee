//= require lib/vendor/jquery-2.0.3
//= require lib/vendor/device
//= require lib/vendor/google-analytics

$('form .trigger').focus ->
  $('form .hidden').slideDown('medium')
  $('form a.hide').show()

  $('form a.hide').on 'click', ->
    $('form .hidden').slideUp('medium')
    $('form a.hide').hide()

$('.flash a.hide').on 'click', ->
  $(@).parent().parent().hide()
