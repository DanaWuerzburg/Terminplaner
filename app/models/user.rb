class User < ActiveRecord::Base

  has_many :appointments
  has_many :groups,     :through => :appointments

  has_many :friends, :through => :friendships, :conditions => "status = 'accepted'"
  has_many :appointments,:through =>:friendships, :source => :friend, :conditions => "selected = 'true'"
    #has_many :appointments,:through =>:friends

  has_many :requested_friends, :through => :friendships, :source => :friend, :conditions => "status = 'requested'", :order => :created_at
  has_many :pending_friends, :through => :friendships, :source => :friend, :conditions => "status = 'pending'", :order => :created_at
  has_many :friendships, :dependent => :destroy

  #next try
  has_many :shared_friends, :through => :friendship_appointments
  has_many :appointments,:through =>:friendship_appointments, :source => :shared_friends
  has_many :friendship_appointments, :dependent => :destroy



  acts_as_authentic do |c|
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
    # ehemaliger befehl:
    #"#{self.login}  <#{self.email}>"
    "#{self.login} <#{"rubyprojekt@googlemail.com"}>" #
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.password_reset_instructions(self).deliver
  end

  def create_no_group
    gr = Group.create \
                  :name => 'No Group',
                  :description => '',
                  :colour => '#ffffff',
                  :user_id => self.id
  end


end
