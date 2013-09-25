Recall::Web.controllers :users do
  get :new, map: '/join' do
    render 'users/new'
  end

  post :create do
    u = UserCreate.run({
      user: params[:user],
      password: params[:password]
    })

    if u.success?
      session[:recall] = u.result.id
      redirect url(:index)
    else
      flash[:error] = u.errors.message_list
      redirect url(:users, :new)
    end
  end

  get :edit, map: '/settings' do
    @user = current_user

    render 'users/edit'
  end

  patch :update do
    u = UserUpdate.run({
      current_user: current_user,
      user: params[:user]
    })

    if u.success?
      flash[:notice] = 'User information saved.'

      redirect url(:users, :edit)
    else
      flash[:error] = u.errors

      redirect url(:users, :edit)
    end
  end
end
