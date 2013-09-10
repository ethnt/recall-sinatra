Recall::Web.controllers :sessions do
  get :new, map: '/login' do
    render 'sessions/new'
  end
end
