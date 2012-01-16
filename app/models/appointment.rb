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
    find(:all, :conditions => ['note LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
end
end
