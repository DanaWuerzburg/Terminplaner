class CalendarController < ApplicationController
  
  def index
    @group = Group.new
    @groups = Group.find(:all, :conditions => {:user_id => current_user})

    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    @event_strips = Appointment.event_strips_for_month(@shown_month)
  end
  
end
