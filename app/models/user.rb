class User < ActiveRecord::Base

  has_many :appointments
  has_many :groups,     :through => :appointments


  acts_as_authentic do |config|
    #	Add	custom	conﬁgura'on	op'ons	here
    #config.crypto_provider = Authlogic::CryptoProviders::MD5
  end

  def self.find_by_login_or_email(login)
   find_by_login(login) || find_by_email(login)
  end

  def admin?
    return admin || (id == 1)
  end

  def active?
    return active  || (id == 1)
  end

  def activate!
    self.active = true
    save
  end

  def deactivate!
    self.active = false
    save
  end

  def send_activation_instructions!
    reset_perishable_token!
    Notifier.activation_instructions(self).deliver
  end

  def send_activation_confirmation!
    reset_perishable_token!
    Notifier.activation_confirmation(self).deliver
  end

  def email_address_with_name
    #TODO  Alle Adressen werden zur RUBY Test adresse geschickt,
    # ehemaliger befehl: self.login}  <#{self.email}>
    "#{self.login} <#{"rubyprojekt@googlemail.com"}>" #
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.password_reset_instructions(self).deliver
  end

end
