require 'sinatra/base'
require_relative './spec/database_connection_setup'

# require 'sinatra/flash'

# draws on the Sinatra base for the app
class ApplicationManager < Sinatra::Base
  get '/' do
    erb(:index)
  end

  get '/spaces/add' do
    erb :add_space
  end

  get 'users/new' do
    erb :register
  end
  run! if app_file == $0
end
