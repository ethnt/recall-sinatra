Recall::Web.helpers do
  def current_user
    if session[:recall]
      User.find(session[:recall])
    end
  end

  def redirect!
    if current_user
      gon.access_token = current_user.access_token
    else
      redirect url(:index)
    end
  end
end
