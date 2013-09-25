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

    if params[:redirect]
      redirect_to = params[:redirect]
    else
      redirect_to = url(:courses, :index)
    end

    if c.success?
      redirect redirect_to
    else
      flash[:error] = c.errors.message_list
      redirect redirect_to
    end
  end

  get :show, :map => '/c/:id' do
    @course = Course.find(params[:id])
    @assignments = Assignment.where(user_id: current_user.id, course_id: @course.id, complete: false)

    render 'courses/show'
  end
end
