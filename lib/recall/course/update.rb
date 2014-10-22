class CourseUpdate < RecallMutation
  required do
    model :current_user, class: User
    hash :course do
      string :id
      string :name
      string :code
      boolean :hidden
    end
  end

  def execute
    c = Course.find(course['id'])

    unless current_user.can_update?(c)
      add_error(:current_user, :unauthorized, 'user cannot perform this action')
    end

    c.update_attributes(course)

    c.save

    c
  end
end
