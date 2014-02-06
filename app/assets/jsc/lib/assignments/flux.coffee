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
