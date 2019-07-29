require 'sinatra/base'
# require 'sinatra/flash'

# draws on the Sinatra base for the app
class ApplicationManager < Sinatra::Base
  get '/' do
    erb(:index)
  end

  run! if app_file == $0
end
