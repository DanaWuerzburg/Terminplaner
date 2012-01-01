# config/initializers/mail.rb

ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => 'gmail.com',
  :user_name => '[your username]',
  :password => '[your password]',
  :authentication => 'plain',
  :enable_starttls_auto => true
}
