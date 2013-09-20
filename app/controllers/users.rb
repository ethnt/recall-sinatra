Recall::Web.controllers :users do
  get :new, map: '/join' do
    render 'users/new'
  end

  post :create do
    u = UserCreate.run({
      user: params[:user]
    })

    if u.success?
      session[:recall] = u.result.id
      redirect url(:index)
    else
      flash[:error] = u.errors
      redirect url(:users, :new)
    end
  end

  get :edit, map: '/settings' do
    @user = current_user

    render 'users/edit'
  end
end
