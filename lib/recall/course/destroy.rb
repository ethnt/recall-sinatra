class CourseDestroy < RecallMutation
  required do
    model :current_user, class: User
    hash :course do
      string :id
    end
  end

  def execute
    c = Course.find(course['id'])

    unless current_user.can_destroy?(c)
      add_error(:current_user, :unauthorized, 'user cannot perform this action')
    end

    c.destroy

    nil
  end
end
