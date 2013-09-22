//= require lib/vendor/jquery-1.10.2

$('.trigger').focus ->
  div = $('.hidden').slideDown('medium')
  $(document).bind 'focusin.hidden click.hidden', (e) ->
    return  if $(e.target).closest('.hidden, .trigger').length
    $(document).unbind '.hidden'
    div.slideUp('medium')

$('.hidden').hide()
