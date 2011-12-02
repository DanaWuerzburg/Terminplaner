class User < ActiveRecord::Base

  acts_as_authentic do |config|
    #	Add	custom	conﬁgura'on	op'ons	here
    config.crypto_provider = Authlogic::CryptoProviders::MD5
  end

end
