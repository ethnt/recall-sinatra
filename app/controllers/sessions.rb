Recall::Web.controllers :sessions do
  get :new, map: '/login' do
    render 'sessions/new'
  end

  post :create do
    u = User.authenticate(params[:email], params[:password])

    if u
      session[:recall] = u.id
      redirect url(:index)
    else
      flash[:error] = 'User not found'
      redirect url(:sessions, :new)
    end
  end

  get :destroy, map: '/logout' do
    session[:recall] = nil

    redirect url(:index)
  end
end
