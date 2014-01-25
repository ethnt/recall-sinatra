Recall::API.controllers :assignments do
  before do
    redirect!
  end

  get :show, map: '/assignments/:id', provides: [:json] do
    @assignment = Assignment.find(params[:id])

    render 'assignments/show'
  end

  post :create, provides: [:json] do
    params[:assignment][:due] = Date.parse(params[:assignment][:due])

    a = AssignmentCreate.run(
      current_user: current_user,
      course: Course.find(params[:assignment][:course]),
      assignment: params[:assignment]
    )

    if a.success?
      @assignment = a.result

      render 'assignments/show'
    else
      flash[:error] = a.errors
      redirect redirect_to
    end
  end

  post :flux, provides: [:json] do
    a = AssignmentFlux.run(
      current_user: current_user,
      assignment: params[:assignment]
    )

    if a.success?
      @assignment = a.result

      render 'assignments/show'
    else
      flash[:error] = a.errors

      redirect url(:index)
    end
  end
end
