class Group < ActiveRecord::Base
  has_many :appointment
  belongs_to :user


  validates :user_id, :presence => true

end
