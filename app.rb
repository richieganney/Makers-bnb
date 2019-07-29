require 'sinatra/base'
require_relative './spec/database_connection_setup'

# require 'sinatra/flash'

# draws on the Sinatra base for the app
class ApplicationManager < Sinatra::Base
  get '/' do
    erb(:index)
  end

  run! if app_file == $0
end
