class AssignmentCreate < Mutations::Command
  required do
    model :current_user, class: User
    model :course
    hash :assignment do
      string :text
    end
  end

  def execute
    if current_user.can_update?(course)
      a = Assignment.new(assignment)
      a.course = course
      a.save

      return a
    else
      add_error(:current_user, 'the current user is not authorized')
    end
  end
end
