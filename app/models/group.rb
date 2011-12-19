class Group < ActiveRecord::Base
  has_many :appointments
  has_one :user, :through =>  :appointments


  validates :user_id, :presence => true

end
