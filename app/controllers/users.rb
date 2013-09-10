Recall::Web.controllers :users do
  get :new, map: '/join' do
    render 'users/new'
  end
end
