require 'sinatra/base'
require './lib/spaces'
require_relative './spec/database_connection_setup'

# require 'sinatra/flash'

# draws on the Sinatra base for the app
class ApplicationManager < Sinatra::Base
  get '/' do
    @listings = Spaces.all
    erb(:index)
  end

  post '/spaces/add' do
    result1 = DatabaseConnection.query(
      "INSERT INTO users (first_name)
       VALUES ('dan')
       RETURNING user_id;"
    )
    Spaces.add(params[:address], params[:title], params[:description], params[:price_per_night], result1[0]['user_id'])
    redirect('/')
  end

  get '/spaces/add' do
    erb :add_space
  end

  get 'users/new' do
    erb :register
  end
  run! if app_file == $0
end
