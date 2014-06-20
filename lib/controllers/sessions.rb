get '/sessions/new' do 
	erb :"sessions/new"
end

post '/sessions' do 
	email, password = params[:email], params[:password]
	user = User.authenticate(email, password)
	if user
		session[:user_id] = user.id
		redirect to('/')
	else
		flash[:errors] = ["The email or password is incorrect"]
		erb :"sessions/new"
	end
end

delete '/sessions' do 
	flash[:notice] = "Good bye!"
	session[:user_id] = nil
	erb :"sessions/new"
	# redirect to('/')
end

get '/sessions/forgotten_password' do 
	erb :"sessions/forgotten_password"
end

post '/sessions/forgotten_password' do 
	email = params[:email]
	user = User.first(:email => email)
	if user
		user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
		user.password_token_timestamp = Time.now
		user.save
		url = "http://stark-dawn-2603.herokuapp.com/users/reset_password?token=#{user.password_token}"
		send_message(email, url)
		flash[:errors] = ""
		flash[:notice] = "A link has been sent to you to reset your password"
		erb :"sessions/new"
	else
		flash[:notice] = ""
		flash[:errors] = "This email does not exist"
		erb :"sessions/forgotten_password"
	end
end