Padrino.configure_apps do
  # enable :sessions

  # set :protection, true
  # set :protect_from_csrf, true

  set :session_secret, '73c11834a4ebf03dbce5bccf0f21b92c47c05ac501542310f6c7aef41dbda417'

  Analytics.init(secret: ENV['ANALYTICS_SECRET'])
end

# Mounts the core application for this project
Padrino.mount('Recall::Web', app_file: Padrino.root('app/app.rb')).to('/')
