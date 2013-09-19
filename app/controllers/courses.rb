Recall::Web.controllers :courses do
  before do
    redirect!
  end

  get :index do
    @courses = Course.where(user_id: current_user.id).asc(:name)

    render 'courses/index'
  end

  post :create do
    c = CourseCreate.run({
      current_user: current_user,
      course: params[:course]
    })

    if c.success?
      if params[:redirect]
        redirect url(:index)
      else
        redirect url(:courses, :index)
      end
    else
      redirect url(:courses, :index)
    end
  end
end
