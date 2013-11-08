Spine      = require('spine')
Assignment = require('models/assignment')
$          = Spine.$

class Assignments extends Spine.Controller
  className = 'assignments'

  constructor: ->
    super
