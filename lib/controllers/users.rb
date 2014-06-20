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

get '/users/reset_password' do 
	token = params[:token]
	@user = User.first(:password_token => token)
	time = @user.password_token_timestamp
	if @user && Time.now >= time + (60 * 60) 
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
		@user.update(:password => params[:password], :password_confirmation => params[:password_confirmation], :password_token => "", :password_token_timestamp => "")
		redirect to('/')
	else
		flash[:errors] = "There was a problem with the update please try again"
		erb :"users/new"
	end
end

# def send_message(user)
#   RestClient.post "https://#{API_KEY}"\
#   "@api.mailgun.net/v2/app26576893.mailgun.org/messages",
#   :from => "Very Excited User <me@app26576893.mailgun.org>",
#   :to => "#{user.email}",
#   :subject => "Hello",
#   :text => "Please click on the following email to reset your password <a href="http://stark-dawn-2603.herokuapp.com/users/reset_password/<%=token%>">
# end