Recall::Web.controllers :courses do
  get :index do
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
