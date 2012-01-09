class AppointmentsController < ApplicationController

  before_filter :require_user, :only  => [:edit, :index, :new , :show , :destroy]
  # GET /appointments
  # GET /appointments.json


  helper_method :sort_column, :sort_direction

  def index
    @groups = Group.all
    @group = Group.new

    @groups = Group.find(:all, :conditions => {:user_id => current_user})

    #TODO Die Gruppe "keine gruppe" sollte bei jedem frisch generierten user existieren
    @group = Group.new(:name=>"No Group",:description=>"",:colour=>"#ffffff")

    #TODO Appointments nach Groupid anzeigen lassen können

   #ordnet inhalte je nach spalte
    @appointments = Appointment.order(sort_column + " " + sort_direction)
   # @appointments= Appointment.all
    @appointment = Appointment.new

      ##### Admin rechte verwalten
    if current_user.admin?
      #admin darf alle termine sehen und verwalten und nach user sortieren

    else
      #wenn der User kein Admin ist, werden nur com user angelegte Termine gezeigt
      @appointments = Appointment.find(:all, :conditions => {:user_id => current_user})


    end


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
    @appointment = Appointment.find(params[:id])
  end

  # POST /appointments
  # POST /appointments.json
  def create
      #@groups = Group.all
      #@appointment = Appointment.new(params[:appointment])

      @appointment = Appointment.new(params[:appointment].merge(:user =>current_user )) #user id mit user verknüpfen
      #@appointment = Appointment.new(params[:appointment].merge(:user =>current_user , :group_id => current_group.id)) #user id mit user verknüpfen


      if @appointment.save
        flash[:notice] = 'Der Termin wurde hinzugefuegt '
        redirect_to :action => :index and return

    else
    #render :text => "MIST"    #HAHAHA das hatt ich grad aufm screen und mich gewundert >.<
     render json: @appointment.errors, status: :unprocessable_entity
    end
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

end
