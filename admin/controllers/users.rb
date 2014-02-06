Recall::Admin.controllers :users do
  get :index do
    @users = User.desc(:updated_at).limit(50)

    render 'users/index'
  end
end
