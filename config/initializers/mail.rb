# config/initializers/mail.rb

#Someone need to organize a gmail account just for ruby

#name       Ruby
#lastname   Projekt
#accname    rubyprojekt
#passwort   rootroot
#birthdate  01.01.1980

#rubyprojekt@googlemail.com

ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => 'gmail.com',
  :user_name => 'rubyprojekt',
  :password => 'rootroot',
  :authentication => 'plain',
  :enable_starttls_auto => true
}
