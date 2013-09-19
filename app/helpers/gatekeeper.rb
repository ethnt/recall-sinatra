Recall::Web.helpers do
  def current_user
    if session[:recall]
      User.find(session[:recall])
    end
  end

  def redirect!
    unless current_user
      redirect url(:index)
    end
  end
end
