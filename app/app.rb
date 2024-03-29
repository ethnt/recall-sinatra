module Recall
  class Web < Padrino::Application
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Sprockets
    register Gon::Sinatra

    configure :development do
      use BetterErrors::Middleware

      BetterErrors.application_root = PADRINO_ROOT
    end

    enable :sessions

    set :sessions, expire_after: 1.year

    assets = [
      'assets/css',
      'assets/jsc',
      'assets/img',
      'assets/webfonts'
    ]

    sprockets url: 'assets', minify: (Padrino.env == :production), paths: assets
  end
end
