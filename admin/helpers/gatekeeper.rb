Recall::Admin.helpers do
  def current_user
    if session[:recall]
      User.find(session[:recall])
    end
  end

  def redirect!
    if current_user && current.user.administrator == true
      gon.access_token = current_user.access_token
    else
      redirect Recall::Web.url(:index)
    end
  end
end
