class AssignmentDestroy < Mutations::Command
  required do
    model :current_user, class: User
    hash :assignment do
      string :id
    end
  end

  def execute
    a = Assignment.find(assignment['id'])

    if current_user.can_destroy?(a)
      a.destroy

      return nil
    else
      add_error(:current_user, 'the current user is not authorized')
    end
  end
end
