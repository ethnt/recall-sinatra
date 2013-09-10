Recall::Web.helpers do
  def current_user
    if session[:recall]
      User.find(session[:recall])
    end
  end
end
