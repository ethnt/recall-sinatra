class AssignmentFlux < Mutations::Command
  required do
    model :current_user, class: User
    hash :assignment do
      string :id
    end
  end

  def execute
    a = Assignment.find(assignment['id'])

    if current_user.can_update?(a)
      a.complete = !a.complete
      a.save

      if a.complete
        event = 'Finished Assignment'
      else
        event = 'Unfinished Assignment'
      end

      Analytics.track(
        user_id: current_user.id.to_s,
        event: event,
        properties: {
          id: a.id.to_s,
          text: a.text,
          due: a.due,
          course: {
            id: a.course.id.to_s,
            name: a.course.name,
            code: a.course.code
          }
        }
      )

      return a
    else
      add_error(:current_user, :unauthorized, 'the current user is not authorized')
    end
  end
end
