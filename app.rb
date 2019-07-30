require 'sinatra/base'
require './lib/user'
require './lib/spaces'
require_relative './spec/database_connection_setup'
require './lib/user'

# require 'sinatra/flash'

# draws on the Sinatra base for the app
class ApplicationManager < Sinatra::Base

  enable :sessions

  get '/register' do
    erb :register
  end

  post '/users/new' do
    user = User.add(email: params[:email], first_name: params[:first_name], last_name: params[:last_name], password: params[:password], mobile: params[:mobile])
    session[:user] = user
    redirect '/'
  end

  get '/' do
    @user = session[:user]
    erb(:index)
  end

  post '/users/new' do
    user = User.add(email: params[:email], first_name: params[:first_name], last_name: params[:last_name], password: params[:password], mobile: params[:mobile])
    session[:user] = user
    redirect '/'
  end

  get '/sessions/new' do
    erb :"sessions/new"
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])

    if user
      session[:user] = user
      redirect '/'
    else
      redirect('/sessions/new')
    end
  end

  post '/sessions/destroy' do
    session.clear
    redirect('/')
  end

  post '/spaces/add' do
    @user = session[:user]
    Spaces.add(params[:address], params[:title], params[:description], params[:price_per_night], @user.user_id)
    redirect('/')
  end

  get '/spaces/add' do
    erb :"spaces/add"
  end

  get '/spaces' do
    @all_spaces = Spaces.all
    erb :"spaces/spaces"
  end

  get '/spaces/:space_id' do
    @space = Spaces.find(params[:space_id])
    erb :"spaces/book"
  end

  run! if app_file == $0
end
