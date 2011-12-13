class User < ActiveRecord::Base

  has_many :appointment
  has_many :groups

  acts_as_authentic do |config|
    #	Add	custom	conﬁgura'on	op'ons	here
    config.crypto_provider = Authlogic::CryptoProviders::MD5
  end

  def admin?
    return admin || (id == 1)
  end

end
