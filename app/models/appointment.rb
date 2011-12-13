class Appointment < ActiveRecord::Base
  belongs_to :user
     has_one :group

  validates :user_id, :presence => true

end
