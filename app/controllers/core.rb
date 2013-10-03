Recall::Web.controllers do
  get :index do
    if current_user
      @course_options = Course.as_options(current_user)
      @assignments = Assignment.where(user_id: current_user.id, complete: false).asc(:created_at)

      render 'core/dashboard'
    else
      @css = ['/assets/css/lib/pages/index.css']

      render 'core/index'
    end
  end

  get :about do
    render 'core/about'
  end
end
