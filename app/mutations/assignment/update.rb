class AssignmentUpdate < Mutations::Command
  required do
    model :current_user, class: User
    hash :assignment do
      string :id
      string :text
    end
  end

  def execute
    a = Assignment.find(assignment['id'])

    if current_user.can_update?(a)
      a.update_attributes(assignment)
      a.save

      return a
    else
      add_error(:current_user, 'the current user is not authorized')
    end
  end
end
