# get '/forgotten_password' do 
# 	erb :"sessions/forgotten_password"
# end

# post'/forgotten_password' do 
# 	email = params[:email]
# 	user = User.first(:email => email)
# 	if user
# 		user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
# 		user.password_token_timestamp = Time.now
# 		user.save
# 		flash[:errors] = ["A link has been send to you to reset your password"]
# 		erb :"sessions/new"
# 	else
# 		flash[:errors] = ["This email is not yet registered"]
# 		erb :"users/new"
# 	end
# end