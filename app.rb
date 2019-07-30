require 'sinatra/base'
require './lib/spaces'
require_relative './spec/database_connection_setup'
require './lib/user'

# require 'sinatra/flash'

# draws on the Sinatra base for the app
class ApplicationManager < Sinatra::Base

  enable :sessions

  get '/' do
    @listings = Spaces.all
    @user = session[:user]
    erb(:index)
  end

  post '/spaces/add' do
    @user = session[:user]
    Spaces.add(params[:address], params[:title], params[:description], params[:price_per_night], @user.user_id)
    redirect('/')
  end

  get '/spaces/add' do
    erb :add_space
  end

  get '/register' do
    erb :register
  end

  post '/users/new' do
    user = User.add(email: params[:email], first_name: params[:first_name], last_name: params[:last_name], password: params[:password], mobile: params[:mobile])
    session[:user] = user
    redirect '/'
  end

  run! if app_file == $0
end
