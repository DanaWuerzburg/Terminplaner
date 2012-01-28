class AppointmentsController < ApplicationController

  before_filter :require_user, :only  => [:edit, :index, :new , :show , :destroy]

  # GET /appointments
  # GET /appointments.json


  helper_method :sort_column, :sort_direction, :selected_friend


  attr_accessor :friends_array

  def index
    @groups = Group.all
    @group = Group.new
    @groups = Group.find(:all, :conditions => {:user_id => current_user})

    @users= User.all
    @shared_friendships = FriendshipAppointment.all
    @shared_friendship = FriendshipAppointment.new



   #ordnet inhalte je nach spalte
    @appointments = Appointment.order(sort_column + " " + sort_direction)

    @appointment = Appointment.new

    ##### Admin rechte verwalten
    if current_user.admin?
      #admin darf alle termine sehen und verwalten und nach user sortieren

    else
      #wenn der User kein Admin ist, werden nur com user angelegte Termine gezeigt
      @appointments = Appointment.find(:all, :conditions => {:user_id => current_user})
    end
    #################
    # Diese Zeile verursacht, dass jeder User die Termine aller anderenuser sehen kann
    # Wenn man diese zeile nach oben verschiebt funktioniert sie allerdings nicht mehr =((
    @appointments = Appointment.search(params[:search])
    #################

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @appointments, :notice => 'Appointment in index.' }
    end
    end



  def zeit
    puts "HEYHOHELLO"
  end
  # GET /appointments/1
  # GET /appointments/1.json
  def show
    @users= User.all
    @shared_friendships = FriendshipAppointment.all
    @shared_friendship = FriendshipAppointment.new

    @appointment = Appointment.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @appointment }
    end
  end

  # GET /appointments/new
  # GET /appointments/new.json
  def new
    @groups = Group.all
    @group = Group.new

    @shared_friendships = FriendshipAppointment.all
    @shared_friendship = FriendshipAppointment.new

    @appointment = Appointment.new
    #@appointment.user_id = current_user.id
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @appointment, :notice => 'Appointment in new' }
    end

  end

  # GET /appointments/1/edit
  def edit
    @groups = Group.all
    @group = Group.new
    @shared_friendships = FriendshipAppointment.all
    @shared_friendship = FriendshipAppointment.new

    @appointment = Appointment.find(params[:id])
  end

  # POST /appointments
  # POST /appointments.json
  def create

      @appointment = Appointment.new(params[:appointment].merge(:user =>current_user )) #user id mit user verknüpfen


      if @appointment.save
        #FriendshipAppointment.where(:appointment_id => @appointment.id).update_all(:user =>current_user)
        flash[:notice] = 'Der Termin wurde hinzugefuegt '
        redirect_to :action => :index and return

      else
       render json: @appointment.errors, status: :unprocessable_entity
      end
      #FriendshipAppointment.where(:appointment_id => @appointment.id).update_all(:user =>current_user)

  end

  # PUT /appointments/1
  # PUT /appointments/1.json
  def update
    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      if @appointment.update_attributes(params[:appointment])
        strg = "#{@appointment.note}"
        flash[:notice] = "Updated appointment:  " + strg[0..30] + "..."
        format.html { redirect_to :action => :index and return }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    respond_to do |format|
       flash[:notice] = 'Appointment was deleted'
      format.html { redirect_to appointments_url }
      format.json { head :ok }
    end
  end

  #########################
  private

  def sort_column
    Appointment.column_names.include?(params[:sort]) ? params[:sort] : "date"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def selected_friends
    current_user.friends.each do |friend|
       if friend.selected
         friends_array.push(friend)
       end
    end
  end




end
