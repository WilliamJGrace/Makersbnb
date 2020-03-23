require 'sinatra/base'

class Makers_Bnb < Sinatra::Base


  get '/' do
    erb :index
  end

  run! if app_file == $0

end
