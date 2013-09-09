class CourseCreate < Mutations::Command
  required do
    model :current_user, class: User
    hash :course do
      string :name
    end
  end

  def execute
    c = Course.new(course)
    c.user = current_user
    c.save

    return c
  end
end
