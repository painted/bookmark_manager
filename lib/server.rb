require 'sinatra'
require 'data_mapper'
require './lib/link'
require './lib/tag'
require './lib/user'
require_relative 'data_mapper_setup'
require_relative 'helpers/application'

set :public_folder, Proc.new {File.join(root, '..', "public")}

enable :sessions
set :session_secret, 'super secret'

get '/' do 
	@links = Link.all 
	erb :index	
end

post '/links' do
  url = params["url"]
  title = params["title"]
  tags = params["tags"].split(" ").map{|tag| Tag.first_or_create(:text => tag)}
  Link.create(:url => url, :title => title, :tags => tags)
  redirect to('/')
end

get '/tags/:text' do
	tag = Tag.first(:text => params[:text])
	@links = tag ? tag.links : []
	erb :index
end

get '/users/new' do 
	erb :"users/new"
end

post '/users' do 
	user = User.create(:email => params[:email],
				:password => params[:password])
	session[:user_id] = user.id 
	redirect to('/')
end
