require 'sinatra/base'
require './lib/Listing'
require './lib/User'
require './lib/requests'
require './database_connection_setup'
require 'pg'
require 'sinatra/flash'

class Makers_Bnb < Sinatra::Base
  register Sinatra::Flash

  enable :sessions, :method_override

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
    if user
      session[:user_id] = user.id
      redirect '/listings'
    else
      flash[:notice] = 'username already taken'
      redirect '/users/new'
    end
  end

  get '/listings' do
    @user = User.find(session[:user_id]) if session[:user_id] != nil
    @listings = Listing.all
    erb :listings
  end

  get '/listings/:id/new' do
    @user_id = params[:id]
    erb :new_space
  end

  post '/listings/:id/new' do
    Listing.create(user_id: params[:id],name: params[:name],description: params[:description],price: params[:price],dates_available: params[:dates_available], img_url: params[:img_url])

    redirect '/listings'
  end

  delete '/listings/:listing_id/:user_id/delete' do
    Listing.delete(id: params[:listing_id])
    redirect '/listings'
  end

  get '/listings/:listing_id/:user_id/edit' do
    @user_id = params[:user_id]
    @listing = Listing.find(params[:listing_id])
    erb :edit_listing
  end

  post '/listings/:id/request' do
    current_session_user = User.find(session[:user_id])
    current_listing = Listing.find(params[:id])
    request = Requests.create(listing_user_id: current_listing.user_id, requester_user_id: session[:user_id], listing_id: current_listing.id, name: current_listing.name, description: current_listing.description, price: current_listing.price, dates_booked: params[:dates_booked])
    redirect '/listings/my-requests'
  end


  get '/listings/my-requests' do
    @user = User.find(session[:user_id])
    @requests = Requests.all
    erb :my_bookings
  end
  delete '/listings/:request_id/delete-request' do
    Requests.delete_request(id: params[:request_id])
    redirect '/listings/my-requests'
  end

  delete '/listings/:request_id/deny-request' do
    Requests.delete_request(id: params[:request_id])
    redirect '/listings/my-requests'
  end

  patch '/listings/:request_id/confirm-request' do
    Requests.confirm_booking(id: params[:request_id])
    redirect '/listings/my-requests'
  end



  patch '/listings/:listing_id/:user_id' do
    Listing.update(id: params[:listing_id], name: params[:name], description: params[:description], price: params[:price], dates_available: params[:dates_available], img_url: params[:img_url])
    redirect ('/listings')
  end

  get '/listings/requested' do
    erb :book_space
  end

  post '/sign-out' do
    session.clear
    redirect '/sign-out-page'
  end

  get '/sign-out-page' do
    erb :sign_out
  end


  run! if app_file == $0
end
