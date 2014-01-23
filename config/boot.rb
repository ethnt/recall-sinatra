PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

require 'rubygems' unless defined?(Gem)
require 'bundler/setup'

Bundler.require(:default, PADRINO_ENV)

if defined?(LogBuddy)
  LogBuddy.init(
    logger:   logger,
    disabled: PADRINO_ENV == :production
  )
end

def heroku?
  ENV['HEROKU']
end

if defined?(Dotenv) && !heroku?
  Dotenv.load!
end

Padrino.after_load do
  Padrino.require_dependencies(Padrino.root('app/mailers/**/*.rb'))
  Padrino.require_dependencies(Padrino.root('app/mutations/**/*.rb'))
end

Padrino.load!
