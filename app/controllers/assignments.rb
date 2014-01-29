Recall::Web.controllers :assignments do
  before do
    redirect!
  end

  get :index, map: '/a' do
    @assignments = Assignment.where(user_id: current_user.id, complete: false).asc(:due)
    @completed = Assignment.where(user_id: current_user, complete: true).desc(:updated_at)

    render 'assignments/index'
  end

  post :create do
    params[:assignment][:due] = Date.parse(params[:assignment][:due])

    a = AssignmentCreate.run(
      current_user: current_user,
      course: Course.find(params[:assignment][:course]),
      assignment: params[:assignment]
    )

    if params[:redirect]
      redirect_to = params[:redirect]
    else
      redirect_to = url(:index)
    end

    if a.success?
      redirect redirect_to
    else
      flash[:error] = a.errors
      redirect redirect_to
    end
  end

  patch :flux do
    a = AssignmentFlux.run(
      current_user: current_user,
      assignment: params[:assignment]
    )

    if a.success?
      redirect url(:index)
    else
      flash[:error] = a.errors

      redirect url(:index)
    end
  end

  get :show, map: '/a/:id' do
    @assignment = Assignment.find(params[:id])

    render 'assignments/show'
  end

  patch :update do
    params[:assignment][:due] = Date.parse(params[:assignment][:due])

    a = AssignmentUpdate.run(
      current_user: current_user,
      course: Course.find(params[:assignment][:course]),
      assignment: params[:assignment]
    )

    if a.success?
      redirect url(:index)
    else
      flash[:error] = a.errors.message_list
      redirect url(:assignments, :show, id: params[:assignment][:id])
    end
  end

  delete :destroy do
    a = AssignmentDestroy.run(
      current_user: current_user,
      assignment: params[:assignment]
    )

    if params[:redirect]
      redirect_to = params[:redirect]
    else
      redirect_to = url(:index)
    end

    if a.success?
      redirect redirect_to
    else
      flash[:error] = a.errors

      redirect url(:index)
    end
  end
end
