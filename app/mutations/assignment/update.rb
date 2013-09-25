class AssignmentUpdate < Mutations::Command
  required do
    model :current_user, class: User
    model :course
    hash :assignment do
      string :id
      string :text
      model  :due, class: Date
    end
  end

  def execute
    a = Assignment.find(assignment['id'])

    if current_user.can_update?(a)
      a.update_attributes(assignment)

      if course != a.course
        a.course = course
      end

      a.save

      return a
    else
      add_error(:current_user, 'the current user is not authorized')
    end
  end
end
