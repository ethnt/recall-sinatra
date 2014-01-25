//= require lib/vendor/jquery-2.0.3
//= require lib/vendor/google-analytics
//= require lib/vendor/moment

$('form .trigger').focus ->
  $('form .hidden').slideDown('medium')
  $('form a.hide').show()

  $('form a.hide').on 'click', ->
    $('form .hidden').slideUp('medium')
    $('form a.hide').hide()

$('.flash a.hide').on 'click', ->
  $(@).parent().parent().hide()

$('button.flux').on 'click', ->
  assignment = $(@).parent().parent()
  button     = $(@)

  $.ajax(
    method: 'post'
    url: '/api/assignments/flux.json'
    data:
      access_token: gon.access_token
      assignment:
        id: assignment.attr 'data-id'
  ).done (data) ->
    # Remove uncomplete stuff
    if data.assignment.complete == true
      button.removeClass 'complete'
      button.addClass 'uncomplete'

      button.html '<i class="ss-icon">close</i>'

      assignment.removeClass 'false'
      assignment.addClass 'true'
    else
      button.removeClass 'uncomplete'
      button.addClass 'complete'

      button.html '<i class="ss-icon">check</i>'

      assignment.removeClass 'true'
      assignment.addClass 'false'

$('button.create').on 'click', ->
  event.preventDefault()

  form = $(@).closest 'form'

  $.ajax(
    method: 'post'
    url: '/api/assignments/create.json'
    data:
      access_token: gon.access_token
      assignment:
        text: form.find('.text').val()
        due: form.find('.due').val()
        course: form.find('.course').val()
  ).done (data) ->
    due = moment(data.assignment.due)

    $('.pending').prepend("
      <article class='assignment' data-id='#{data.assignment.id.$oid}'>
        <aside>
          <button class='flux complete' type='submit'>
            <i class='ss-icon'>check</i>
          </button>
        </aside>
        <section>
          <div class='text'><a href='#{data.assignment.id.$oid}'>#{data.assignment.text}</a></div>
          <div class='meta'>
            <p>
              <span class='course'><a href='#{data.assignment.course.id.$oid}'>#{data.assignment.course.name}</a></span>
              <span class='due'>
                <i class='ss-icon'>clock</i>
                <span title='#{due.format('dddd, MMMM D, YYYY')}'>#{due.calendar().split(' ')[0].toLowerCase()}</span>
              </span>
            </p>
          </div>
        </section>
      </article>
    ")
