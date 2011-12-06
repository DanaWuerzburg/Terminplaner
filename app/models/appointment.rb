class Appointment < ActiveRecord::Base
  belongs_to :user
     has_one :group

end
