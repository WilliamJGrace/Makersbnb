require 'sinatra/base'
require './lib/Listing'
require './lib/User'
require 'pg'
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
    #Look at this later
    # Listing.create(user_id: params[:user_id], name: params[:name], description: params[:description], price: params[:price], date_created: params[:date_created], dates_available: [:dates_available])
    @user = User.find(session[:user_id]) if session[:user_id] != nil
    @listings = Listing.all
    erb :listings
  end
  get '/listings/:id/new' do
    @listings_id = params[:id]
    erb :new_space
  end
  post '/listings/:id/new' do
    # connection = PG.connect(dbname: 'makersbnb_test')
    # connection.exec("INSERT INTO listings (user_id, name, description, price, date_created, dates_available) VALUES('#{params[:comment]}', '#{params[:id]}');")
    # #  ('#{user_id}', '#{name}', '#{description}', '#{price}', '#{date_created}', '#{dates_available}')
    redirect '/listings'
  end
  get '/listings/[:id]' do
    erb :space_desc
  end
  post '/listings/[:id]' do
    # logic for storing request
    redirect '/listings'
  end

post '/listings/[:id]/request' do

end

get '/listings/[:id]/request' do
  erb :book_space
end

  # post request for logging in
  post '/login' do
    # login for logging in
    redirect '/listings'
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
