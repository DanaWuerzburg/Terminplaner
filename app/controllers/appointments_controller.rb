class AppointmentsController < ApplicationController
   require "rexml/document"
  include REXML
  before_filter :require_user, :only  => [:edit,:index, :new , :show , :destroy]

  # GET /appointments
  # GET /appointments.json
   #das statische um zu testen
   #TODO dynamisch fuellen
     APPOINTMENTLIST = [
    { :priority_number => 3, :date => "24.01.2012", :category => "singaporean", :dish_name => "Fish Head Curry", :group => "Little India" },
    { :priority_number => 3, :date => "24.01.2012",:category => "singaporean", :dish_name => "Pig Organ Soup", :group => "Food Court" },
    { :priority_number =>8, :date => "24.01.2012",:category => "indian", :dish_name => "Chicken Biryani", :group => "Al Ameen's" },
    { :priority_number =>9, :date => "24.01.2012",:category => "german", :dish_name => "Pork Knuckle", :group => "Stammtisch Restaurant" },
    { :priority_number =>10, :date => "24.01.2012",:category => "indian", :dish_name => "Butter Chicken", :group => "Jaggi's Northern Indian Cuisine" },
    { :priority_number =>10, :date => "24.01.2012",:category => "indian", :dish_name => "Chicken Tikka", :group => "Jaggi's Northern Indian Cuisine" },
    { :priority_number =>7,:date => "24.01.2012", :category => "singaporean", :dish_name => "Mutton Murtabak", :group => "Zam Zam Restaurant" },
    { :priority_number =>8,:date => "24.01.2012", :category => "singaporean", :dish_name => "Chicken Murtabak", :group => "Ah Mei Kaya Toast" },
    { :priority_number =>9, :date => "24.01.2012",:category => "western", :dish_name => "Beef Cheek", :group => "Ember Restaurant" },
    { :priority_number =>8,:date => "24.01.2012", :category => "western", :dish_name => "Cowboy Burger", :group => "Brewerkz" },
    { :priority_number =>8,:date => "24.01.2012", :category => "mexican", :dish_name => "Pork Enchilada", :group => "Iguana Cafe" }
  ]

  helper_method :sort_column, :sort_direction, :selected_friend


  attr_accessor :friends_array

  def index
    @groups = Group.all
    @group = Group.new
    @groups = Group.find(:all, :conditions => {:user_id => current_user})

    @users= User.all
    @shared_friendships = FriendshipAppointment.all
    @shared_friendship = FriendshipAppointment.new
    @shared_friendships = FriendshipAppointment.find(:all, :conditions => {:user_id => current_user})

    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i
    @shown_month = Date.civil(@year, @month)
    @event_strips = Appointment.event_strips_for_month(@shown_month)


   #ordnet inhalte je nach spalte
    @appointments = Appointment.order(sort_column + " " + sort_direction)

    @appointment = Appointment.new

    ##### Admin rechte verwalten
    if current_user.admin?
      #admin darf alle termine sehen und verwalten und nach user sortieren
      @appointments = Appointment.search(params[:search])
    else
      #wenn der User kein Admin ist, werden nur com user angelegte Termine gezeigt
      #@appointments = Appointment.find(:all, :conditions => {:user_id => current_user})
      @appointments = Appointment.search2(params[:search],current_user)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @appointments, :notice => 'Appointment in index.' }
      format.xml {render :xml => @appointments}
    end
    end

#liefert fehler:
  #Missing template appointments/show,
  #application/show with
  #{:handlers=>[:erb, :builder, :coffee], :formats=>[:xml], :locale=>[:en, :en]}.
    def with_code

    @appointment = Appointment.find_by_note(params[:note])
    respond_to do |format|

      format.html { render :action => :show}
      #format.json { render json: @appointments, :notice => 'Appointment in index.' }
      format.xml { render :xml => @appointment }
      end
    end


  def zeit
    puts "HEYHOHELLO"
  end
  # GET /appointments/1
  # GET /appointments/1.json
  def show
    @group = Group.new
    @groups = Group.find(:all, :conditions => {:user_id => current_user})

    @users= User.all
    @shared_friendships = FriendshipAppointment.all
    @shared_friendship = FriendshipAppointment.new

    @appointment = Appointment.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @appointment }
      format.xml {render :xml => @appointment, :status => :created, :location => @appointment }
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
      format.xml {render :xml => @appointment}
    end

  end


   def show_with_rexml
    @appointment = Appointment.find(params[:id])
    hijack_response_inline( generate_rexml )
   end
  # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -
  #def getNote
  #  s= String.new
  #  @appointment = Appointment.find(params[:id])
  #  s= @appointment.note.to_s
  #  puts s
   #return s
 #end

  # GET /appointments/1/edit
  def edit
    @groups = Group.all
    @group = Group.new
    @shared_friendships = FriendshipAppointment.all
    @shared_friendship = FriendshipAppointment.new
    @appointment = Appointment.find(params[:id])
    respond_to { |format|
      format.html
      format.xml { render :xml => @appointment } }
  end

  # POST /appointments
  # POST /appointments.json
  def create
      @appointment = Appointment.new(params[:appointment].merge(:user =>current_user )) #user id mit user verknüpfen
      #@appointment = Appointment.new(params[:appointment])
      respond_to do |format|
        if @appointment.save
          @appointment.create_friendshare(params['friendshare'])
          #FriendshipAppointment.where(:appointment_id => @appointment.id).update_all(:user =>current_user)
          flash[:notice] = 'Appointment saved.'
          format.xml  { render :xml => @appointment, :status => :created, :location => @appointment }
          redirect_to :action => :index and return
        else
        render json: @appointment.errors, status: :unprocessable_entity
        format.xml  { render :xml => @appointment.errors, :status => :unprocessable_entity }
        end
      #FriendshipAppointment.where(:appointment_id => @appointment.id).update_all(:user =>current_user)
      end
  end

  # PUT /appointments/1
  # PUT /appointments/1.json
  def update
    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      if @appointment.update_attributes(params[:appointment])

        FriendshipAppointment.where(:appointment_id => @appointment.id).destroy_all
        @appointment.create_friendshare(params['friendshare'])

        strg = "#{@appointment.note}"
        flash[:notice] = "Appointment updated."
        format.xml {render :xml => @appointment}
        format.html { redirect_to :action => :index and return }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
        format.xml { render :xml => @appointment }
      end
    end
  end

  #test fuer layoutV3
  #def about
    #render :action => "index", :layout => "mobile"
  #end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    respond_to do |format|
       flash[:notice] = 'Appointment deleted.'
      format.html { redirect_to appointments_url }
      format.json { head :ok }
    end
  end


  # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -
  def generate_with_rexml
    hijack_response( generate_rexml )
  end

  #########################
  private
 # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -

  # @param out_data [Object]
  def hijack_response( out_data )

    send_data( out_data, :type => "text/xml", :filename => "sample.xml")

  end

  def hijack_response_inline( out_data )

    send_data( out_data, :type => "text/xml", :filename => "sample.xml", :disposition => "inline")

  end

  # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -
  def generate_rexml
    doc = REXML::Document.new
    root = doc.add_element( "Kalender" )
    APPOINTMENTLIST.each{ |element_data|

      appointmentlist_element = root.add_element( "Termin" )

       appointmentlist_element.add_attribute( "Gruppe", element_data[:group] )
       appointmentlist_element.add_attribute( "Prioritaet", element_data[:priority_number] )

        appointmentlist_note_element = appointmentlist_element.add_element( "Notiz" )
       appointmentlist_note_element.add_text( element_data[:dish_name] )

      date_element = appointmentlist_element.add_element( "Date" )
      date_element.add_text( element_data[:date] )
    }
    doc.write( out_string = "", 2 )
    return out_string
  end



  # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -

  def parse_with_rexml( xml_data )
    doc = REXML::Document.new( xml_data )
    REXML::XPath.each( doc, "//AppointmentlistNote" ){ |appointmentlist_note_element|
     if appointmentlist_note_element.text == "Fish Head Curry" or appointmentlist_note_element.text == "Pig Organ Soup"
       parent = appointmentlist_note_element.parent
       parent.attributes["priority_number"] = 6
     end
    }
    doc.write( out_string = "", 2 )
    hijack_response( out_string )
  end
  # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -
   # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -
  def parse_recursive( xml_data )
    doc = REXML::Document.new( xml_data )
    root = doc.root
    root.each_recursive{ |element|
      logger.info "Element: #{element} !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    }
    redirect_to :action => 'index'
  end


  def sort_column
    Appointment.column_names.include?(params[:sort]) ? params[:sort] : "date"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end






end
