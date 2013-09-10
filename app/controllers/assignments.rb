Recall::Web.controllers :assignments do
  get :index do
  end

  post :create do
    a = AssignmentCreate.run({
      current_user: current_user,
      course: Course.find(params[:assignment][:course]),
      assignment: params[:assignment]
    })

    if a.success?
      redirect url(:index)
    else
      flash[:error] = a.errors
      redirect url(:index)
    end
  end
end
