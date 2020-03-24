require 'sinatra/base'
require './lib/Listing'
require './lib/User'
require 'sinatra/flash'

class Makers_Bnb < Sinatra::Base
  register Sinatra::Flash

enable :sessions

  get '/' do
    erb :index
  end

  get '/login' do
    erb :login
  end

  post '/authentication' do
    user = User.authenticate(username: params[:username], password: params[:password])
    if user
      session[:user_id] = user.id
      redirect '/listings'
    else
      flash[:notice] = 'Wrong username or password'
      redirect '/login'
    end
  end

  get '/users/new' do
    erb :user_registration
  end

  post '/create_user' do
    user = User.create(email: params[:email], name: params[:name], username: params[:username], password: params[:password])
    session[:user_id] = user.id
    redirect '/listings'
  end

  get '/listings' do
    @user = User.find(session[:user_id]) if session[:user_id] != nil
    @listings = Listing.all
    erb :listings
  end

  get '/listings/new' do
    erb(:new_space)
  end

  post '/listings/new' do
    # logic for putting in new space
    redirect '/listings'
  end

  get '/listings/[:id]' do
    erb(:space_desc)
  end

  post '/listings/[:id]' do
    # logic for storing request
    redirect '/listings'
  end

  #login page
  get '/login' do
    erb :login
  end

  # post request for logging in
  post '/login' do
    # login for logging in
    redirect '/listings'
  end
  run! if app_file == $0

end
