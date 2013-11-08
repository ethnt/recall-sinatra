class Assignment extends Spine.Model
  @configure "Assignment", "text", "due", "completed"

  validate: ->
    unless @text
      "Text is required"
