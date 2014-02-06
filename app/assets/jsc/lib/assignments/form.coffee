$('form .trigger').focus ->
  $('form .hidden').slideDown('medium')
  $('form a.hide').show()

  $('form a.hide').on 'click', ->
    $('form .hidden').slideUp('medium')
    $('form a.hide').hide()
