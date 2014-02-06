
$('button.create').on 'click', ->
  event.preventDefault()

  form = $(@).closest 'form'
  button = $(@)

  button.html('Working...')
  button.attr('disabled', 'disabled')

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
          <div class='text'>#{data.assignment.render.display_html}</div>
          <div class='meta'>
            <p>
              <span class='course'>#{data.assignment.course.name}</span>
              <span class='due'>
                <i class='ss-icon'>clock</i>
                <span title='#{due.format('dddd, MMMM D, YYYY')}'>#{data.assignment.due_in_words}</span>
              </span>
              <span class='controls'>
                <a href='/a/#{data.assignment.id.$oid}'><i class='ss-icon'>edit</i></a>
              </span>
            </p>
          </div>
        </section>
      </article>
    ")

    form.find('input.text').val('')

    button.html('Save')
    button.removeAttr('disabled')
