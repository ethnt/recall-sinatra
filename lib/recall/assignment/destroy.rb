class AssignmentDestroy < RecallMutation
  required do
    model :current_user, class: User
    hash :assignment do
      string :id
    end
  end

  def execute
    a = Assignment.find(assignment['id'])

    unless current_user.can_destroy?(a)
      add_error(:current_user, :unauthorized, 'user cannot perform this action')
    end

    a.destroy

    nil
  end
end
