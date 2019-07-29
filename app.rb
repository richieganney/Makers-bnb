require 'sinatra/base'
# require 'sinatra/flash'

class ApplicationManager < Sinatra::Base

  get '/' do
    erb(:index)
  end

  run! if app_file == $0

end