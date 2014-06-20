get '/users/new' do 
	@user = User.new
	erb :"users/new"
end

post '/users' do 
	@user = User.new(:email => params[:email],
				:password => params[:password],
				:password_confirmation => params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id 
		redirect to('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
	end
end

get '/users/reset_password/:token' do 
	token = params[:token]
	@user = User.first(:password_token => token)
	if @user
		@user
		erb :"users/create_password"
	else
		flash[:errors] = "Your link has timed out please try again"
		erb :"sessions/forgotten_password"
	end
	# if token == user
	# 	erb :"users/create_password"
end

put '/users' do 
	@user = User.first(:email => params[:email])
	if @user
		@user.update(:password => params[:password], :password_confirmation => params[:password_confirmation])
		redirect to('/')
	else
		flash[:errors] = "There was a problem with the update please try again"
		erb :"users/new"
	end
end