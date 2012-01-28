class FriendshipAppointment < ActiveRecord::Base
  belongs_to :user         , :class_name => 'User', :foreign_key =>'user_id'
  belongs_to :shared_friend, :class_name => 'User', :foreign_key =>'shared_friend_id'
  belongs_to :appointment
end
