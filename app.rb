require 'sinatra/base'

class Makers_Bnb < Sinatra::Base


  get '/' do
    erb :index
  end

  get '/listings' do
    listings = [
      "Lovely house",
      "Romantic get-away",
      "Seaside cottage"
    ]
    listings.join
  end
  run! if app_file == $0

end
