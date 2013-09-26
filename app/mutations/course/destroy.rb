class CourseDestroy < Mutations::Command
  required do
    model :current_user, class: User
    hash :course do
      string :id
    end
  end

  def execute
    c = Course.find(course['id'])

    Assignment.where(course_id: c.id).all.each do |a|
      a.destroy
    end

    if current_user.can_destroy?(c)
      Analytics.track(
        user_id: current_user.id.to_s,
        event: 'Unenrolled',
        properties: {
          id: c.id.to_s,
          name: c.name,
          code: c.code
        }
      )

      c.destroy

      return nil
    else
      add_error(:current_user, 'the current user is not authorized')
    end
  end
end
