class CourseDestroy < Mutations::Command
  required do
    model :current_user, class: User
    hash :course do
      string :id
    end
  end

  def execute
    c = Course.find(course['id'])

    if current_user.can_destroy?(c)
      c.destroy

      return nil
    else
      add_error(:current_user, 'the current user is not authorized')
    end
  end
end
