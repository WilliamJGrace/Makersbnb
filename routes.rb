# index page of the whole app
get '/' do
  erb(:index)
end

# post request for signingup
post '/' do
  # logic for signingup
  redirect '/spaces'
end

#login page
get '/login' do
  erb(:login)
end

# post request for logging in
post '/login' do
  # login for logging in
  redirect '/spaces'
end

# spaces main page
get '/spaces' do
 erb(:spaces)
end

get '/spaces/new' do
  erb(:new_space)
end

post '/spaces/new' do
  # logic for putting in new space
  redirect '/spaces'
end

get '/spaces/[:id]' do
  erb(:space_desc)
end

post '/spaces/[:id]' do
  # logic for storing request
  redirect '/spaces'
end
