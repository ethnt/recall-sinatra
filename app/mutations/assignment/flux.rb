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

      return a
    else
      add_error(:current_user, :unauthorized, 'the current user is not authorized')
    end
  end
end
