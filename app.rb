require 'sinatra/base'
require './lib/Listing'
require './lib/User'
require 'pg'
class Makers_Bnb < Sinatra::Base
  get '/' do
    erb :index
  end
  # post request for signingup
  post '/' do
    # logic for signingup
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
  get '/listings' do
    Listing.create(id: params['id'], user_id: listing['user_id'], name: listing['name'], description: listing['description'],
      price: listing['price'], date_created: listing['date_created'], dates_available: ['dates_available'])
    @listings = Listing.all
    erb :listings
  end
  get '/listings/:id/new' do
    @listings_id = params[:id]
    erb :'new_space'
  end
  post '/listings/:id/new' do
    connection = PG.connect(dbname: 'makersbnb_test')
    connection.exec("INSERT INTO listings (user_id, name, description, price, date_created, dates_available) VALUES('#{params[:comment]}', '#{params[:id]}');")
    #  ('#{user_id}', '#{name}', '#{description}', '#{price}', '#{date_created}', '#{dates_available}')
    redirect '/listings'
  end
  get '/listings/[:id]' do
    erb :space_desc
  end
  post '/listings/[:id]' do
    # logic for storing request
    redirect '/listings'
  end
  run! if app_file == $0
end
