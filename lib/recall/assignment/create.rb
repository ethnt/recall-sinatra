class AssignmentCreate < RecallMutation
  required do
    model :current_user, class: User
    hash :assignment do
      string :text
      date :due
      boolean :complete
      string :notes, nils: true, empty: true
      string :course_id
    end
  end

  def execute
    a = Assignment.new(assignment)

    unless current_user.can_create?(a)
      add_error(:current_user, :unauthorized, 'user cannot perform this action')
    end

    a.save

    a
  end
end
