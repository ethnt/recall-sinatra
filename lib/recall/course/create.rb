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

    mongoid_errors!(c)

    c.save

    c
  end
end
