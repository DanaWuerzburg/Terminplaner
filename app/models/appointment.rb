class Appointment < ActiveRecord::Base
  has_event_calendar
  belongs_to :user
  belongs_to :group


  has_many   :friends , :through => :friendships, :conditions => "status = 'accepted'"
  has_many   :friends , :through => :users
  belongs_to :friend, :class_name => 'User'
  has_many :friendships #, :dependent => :destroy

  #next try
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

  def update_friendshare

  end

  # @param clicked_id [Object]
  def friend_clicked?(clicked_id)
    blubb = false

    unless self.friendship_appointments.empty? then
      self.friendship_appointments.each do |friend|
          if friend.shared_friend_id == clicked_id then
              blubb = true
          end
      end
    end

    return blubb


  end



end
