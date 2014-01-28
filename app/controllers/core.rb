Recall::Web.controllers do
  get :index do
    if current_user
      @course_options = Course.as_options(current_user)
      @assignments = Assignment.where(user_id: current_user.id, complete: false).desc(:due)
      @completed = Assignment.where(user_id: current_user, complete: true).desc(:updated_at).limit(3)

      gon.access_token = current_user.access_token

      render 'core/dashboard'
    else
      render 'core/index', layout: false
    end
  end

  get :about do
    render 'core/about'
  end
end
