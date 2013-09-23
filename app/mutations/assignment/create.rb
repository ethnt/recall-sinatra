class AssignmentCreate < Mutations::Command
  required do
    model :current_user, class: User
    model :course
    hash :assignment do
      string :text
      model  :due, class: Date
    end
  end

  def execute
    if current_user.can_update?(course)
      a = Assignment.new(assignment)
      a.user = current_user
      a.course = course
      a.save

      Analytics.track(
        user_id: current_user.id.to_s,
        event: 'New Assignment',
        properties: {
          id: a.id.to_s,
          text: a.text,
          due: a.due,
          course: {
            id: course.id.to_s,
            name: course.name,
            code: course.code
          }
        }
      )

      return a
    else
      add_error(:current_user, 'the current user is not authorized')
    end
  end
end
