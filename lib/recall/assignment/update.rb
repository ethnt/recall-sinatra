class AssignmentUpdate < RecallMutation
  required do
    model :current_user, class: User
    hash :assignment do
      string :id
      string :text
      date :due
      boolean :complete
      string :notes, nils: true, empty: true
      string :course_id
    end
  end

  def execute
    a = Assignment.find(assignment['id'])

    unless current_user.can_update?(a)
      add_error(:current_user, :unauthorized, 'user cannot perform this action')
    end

    a.update_attributes(assignment)

    mongoid_errors!(a)

    a.save

    a
  end
end
