module Recall
  class Web < Padrino::Application
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Sprockets

    configure :development do
      use BetterErrors::Middleware

      BetterErrors.application_root = PADRINO_ROOT
    end

    configure :development, :production do
      set :delivery_method, smtp: {
        address:              'email-smtp.us-east-1.amazonaws.com',
        port:                 587,
        user_name:            ENV['AMAZON_SES_KEY'],
        password:             ENV['AMAZON_SES_SECRET'],
        authentication:       :plain,
        enable_starttls_auto: true
      }
    end

    configure :test do
      set :delivery_method, :test
    end

    enable :sessions

    assets = [
      'assets/css',
      'assets/jsc',
      'assets/img',
      'assets/webfonts'
    ]

    sprockets url: 'assets', minify: (Padrino.env == :production), paths: assets
  end
end
