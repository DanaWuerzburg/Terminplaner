class Appointment < ActiveRecord::Base
  has_event_calendar
  belongs_to :user
  belongs_to :group


  #friends
  has_many :shared_friends, :through => :friendship_appointments
  belongs_to :shared_friend, :class_name => 'User', :foreign_key =>'shared_friend_id'
  has_many :friendship_appointments, :dependent => :destroy



  validates :user_id, :presence => true
  validates :group_id, :presence => true

  # @param search [Appointment]
 # def self.search(search)
 #   search_condition = "%" + search + "%"

 #   find(:all, :conditions => ['title LIKE ? OR description LIKE ?', search_condition, search_condition])
 # end

   # die einfachere Variante die auch nicht geht
  def self.search(search)
    if search
      find(:all, :conditions => ['note LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

   def self.search2(search,user)
    if search
      where("user_id = #{user.id}"+find_friends(user)).find(:all, :conditions => ['note LIKE ?', "%#{search}%"])
    else
      where("user_id = #{user.id}"+find_friends(user)).find(:all)
    end
   end



  def create_friendshare(friendShares)
    x=[]
    x=friendShares
    unless x.nil? then
      #FriendshipAppointment.all
      x.each do |fid|
          fr1 = FriendshipAppointment.create! \
                  :user_id => self.user_id,
                  :appointment_id => self.id,
                  :shared_friend_id => fid

          fr2 = FriendshipAppointment.create! \
                            :user_id => fid,
                            :appointment_id => self.id,
                            :shared_friend_id => self.user_id
      end
    end
  end

  def friend_clicked?(clicked_id)
    checked = false

    unless self.friendship_appointments.empty? then
      self.friendship_appointments.each do |friend|
          if friend.shared_friend_id == clicked_id then
              checked = true
          end
      end
    end

    return checked
  end

  def self.find_friends(current_user)
    friend_ids = []
     friend_ids << " "
    unless FriendshipAppointment.find_all_by_user_id(current_user).blank?
      FriendshipAppointment.find_all_by_user_id(current_user).each do |friend|
        #friend_ids.push(friend.appointment_id)
        friend_ids << "id = #{friend.appointment_id}"
      end
    end
      all_friend_ids =friend_ids.join(" OR ")
      return all_friend_ids
  end



end
