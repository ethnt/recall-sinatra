Padrino.configure_apps do
  # enable :sessions

  # set :protection, true
  # set :protect_from_csrf, true

  set :session_secret, '73c11834a4ebf03dbce5bccf0f21b92c47c05ac501542310f6c7aef41dbda417'

  Analytics = AnalyticsRuby
  Analytics.init(
    secret: ENV['ANALYTICS_SECRET']
  )
end

Padrino.mount('Recall::Web', app_file: Padrino.root('app/app.rb')).to('/')
Padrino.mount('Recall::API', :app_file => Padrino.root('api/app.rb')).to('/api')

Padrino.mount('Recall::Admin', :app_file => Padrino.root('admin/app.rb')).to('/admin')