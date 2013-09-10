Recall::Web.controllers do
  get :index do
    if current_user
      @course_options = Course.as_options(current_user)
      @assignments = Assignment.where(user_id: current_user.id, complete: false).desc(:created_at)

      render 'core/dashboard'
    else
      render 'core/index', layout: false
    end
  end
end
