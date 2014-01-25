Recall::API.helpers do
  def current_user
    if params[:access_token]
      User.where(access_token: params[:access_token]).first
    end
  end

  def redirect!
    unless current_user
      halt 403, { current_user: 'unauthorized' }.to_json
    end
  end
end
