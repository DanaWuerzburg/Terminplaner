class Appointment < ActiveRecord::Base
  belongs_to :user
  belongs_to :groups

  validates :user_id, :presence => true
  validates :group_id, :presence => true

end
