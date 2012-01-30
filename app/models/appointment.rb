class Appointment < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

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
    @appointments =   find(:all, :conditions => ['note LIKE ? AND {:user_id => current_user}', "%#{search}%"  ])

  else
    find(:all)
  end
  end


  def getNote
    s = String.new
    s=self.note.to_s
    puts s
    return s
  end
end
