class CourseCreate < Mutations::Command
  required do
    model :current_user, class: User
    hash :course do
      string :name
      string :code
    end
  end

  def execute
    c = Course.new(course)
    c.user = current_user
    c.save

    Analytics.track(
      user_id: current_user.id.to_s,
      event: 'Course Enrollment',
      properties: {
        id:   c.id.to_s,
        name: c.name,
        code: c.code
      }
    )

    return c
  end
end
