class CourseCreate < RecallMutation
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

    unless current_user.can_create?(c)
      add_error(:current_user, :unauthorized, 'user cannot perform this action')
    end

    mongoid_errors!(c)

    c.save

    c
  end
end
