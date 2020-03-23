require 'sinatra/base'

class Makers_Bnb < Sinatra::Base


  get '/' do
    "Random Text"
  end

  run! if app_file == $0

end
