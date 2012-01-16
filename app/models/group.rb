class Group < ActiveRecord::Base
  has_many :appointments
  belongs_to :user #, :through =>  :appointments


  validates :user_id, :presence => true


end
