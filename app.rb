require 'sinatra/base'
require './lib/user'
require './lib/spaces'
require './lib/request'
require_relative './spec/database_connection_setup'
require './lib/user'


# draws on the Sinatra base for the app
class ApplicationManager < Sinatra::Base

  enable :sessions
  # register Sinatra::Flash

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

  get '/spaces/:space_id' do
    @space = Spaces.find(params[:space_id])
    erb :"spaces/book"
  end
  
  post '/request/create/:space_id' do
    @guest = session[:user]
    @space = Spaces.find(params[:space_id])
    @host = @space.owner
    Request.create(guest: @guest.user_id, host: @host, space: @space.space_id, requested_date: params[:requested_date])
    redirect('/')
    # flash[:notice] = 'Thank you, Your request has been sent!'
  end

  post '/requests/approve' do

  end

  get '/requests' do
    @user = session[:user]
    @requests_received_by_user = Request.all_user_received(@user.user_id)
    @requests_made_by_user = Request.all_user_sent(@user.user_id)
    @requests_received_info = []
    @requests_received_by_user.each do |request|
      @requests_received_info.push({"space_title" => "#{Spaces.find(request.space).title}", "space_guest" => "#{User.find(request.guest).first_name}" "#{User.find(request.guest).last_name}", "approved" => request.approved})
    end
    @requests_made_info = []
    @requests_made_by_user.each do |request|
      @requests_made_info.push({"space_title" => "#{Spaces.find(request.space).title}", "space_host" => "#{User.find(request.host).first_name}" "#{User.find(request.host).last_name}", "approved" => request.approved})
    end
    erb(:requests)
  end

  run! if app_file == $0
end
