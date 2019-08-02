require 'sinatra/base'
require './lib/user'
require './lib/spaces'
require './lib/request'
require_relative './spec/database_connection_setup'
require './lib/user'

class ApplicationManager < Sinatra::Base

  enable :sessions

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
    user ? session[:user] = user : redirect('/sessions/new')
    redirect('/') if session[:user] = user
  end

  post '/sessions/destroy' do
    session.clear
    redirect('/')
  end

  post '/spaces/add' do
    @user = session[:user]
    Spaces.add(params[:address], params[:title], params[:description],
           params[:price_per_night], @user.user_id, params[:available_from], params[:available_to])
    redirect('/')
  end

  get '/spaces/add' do
    erb :"spaces/add"
  end

  get '/spaces' do
    @all_spaces = Spaces.all
    erb :"spaces/spaces"
  end

  post '/spaces' do
    @all_spaces = Spaces.all
    @start_date = params[:check_in]
    @end_date = params[:check_out]
    @filtered_spaces = Spaces.filter_by_date(@start_date, @end_date)
    erb :"spaces/spaces"
  end

  get '/spaces/:space_id' do
    @space = Spaces.find(params[:space_id])
    erb :"spaces/book"
  end

  post '/request/create/:space_id' do
    @guest = session[:user]
    @space = Spaces.find(params[:space_id])
    @host = User.find(@space.owner)
    Request.create(guest: @guest, host: @host, space: @space, requested_date: params[:requested_date])
    redirect('/')
  end

  post '/requests/approve/:request_id' do
    Request.approve(params[:request_id])
    redirect('/requests')
  end

  post '/requests/deny/:request_id' do
    Request.reject(params[:request_id])
    redirect('/requests')
  end

  get '/requests' do
    @user = session[:user]
    @requests_received_by_user = Request.all_user_received(@user.user_id)
    @requests_made_by_user = Request.all_user_sent(@user.user_id)
    erb(:requests)
  end

  run! if app_file == $0
end
