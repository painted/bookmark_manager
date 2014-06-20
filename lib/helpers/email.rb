require 'rest_client'

API_KEY = `echo $MAILGUN_API`

#API_KEY = ENV['MAILGUN_API_KEY']
API_URL = "https://api:#{API_KEY}@api.mailgun.net/v2/<app26576893.mailgun.org>"

RestClient.post API_URL+"/messages",
    :from => "ev@example.com",
    :to => "ev@mailgun.net",
    :subject => "This is subject",
    :text => "Text body",
    :html => "<b>HTML</b> version of the body!"

def send_message(user)
  RestClient.post "https://#{API_KEY}"\
  "@api.mailgun.net/v2/app26576893.mailgun.org/messages",
  :from => "Very Excited User <me@app26576893.mailgun.org>",
  :to => "#{user.email}",
  :subject => "Hello",
  :text => 'Please click on the following email to reset your password <a href="http://stark-dawn-2603.herokuapp.com/users/reset_password/#{token}">'
  
end
