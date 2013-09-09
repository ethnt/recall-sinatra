class CourseUpdate < Mutations::Command
  required do
    model :current_user, class: User
    hash :course do
      string :id
      string :name
    end
  end

  def execute
    c = Course.find(course['id'])

    if current_user.can_update?(c)
      c.update_attributes(course)
      c.save

      return c
    else
      add_error(:current_user, 'the current user is not authorized')
    end
  end
end
