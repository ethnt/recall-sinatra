Recall::Web.controllers :assignments do
  before do
    redirect!
  end

  get :index do
    @pending   = Assignment.where(user_id: current_user, complete: false).desc(:created_at)
    @completed = Assignment.where(user_id: current_user, complete: true).desc(:created_at)

    render 'assignments/index'
  end

  post :create do
    params[:assignment][:due] = Date.parse(params[:assignment][:due])

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

  patch :flux do
    a = AssignmentFlux.run({
      current_user: current_user,
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