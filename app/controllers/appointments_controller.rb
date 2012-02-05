class AppointmentsController < ApplicationController
  require "rexml/document"
  include REXML
  require 'fastercsv'
  before_filter :require_user, :only  => [:edit,:index, :new , :show , :destroy]

  # GET /appointments
  # GET /appointments.json
   #das statische um zu testen
   #TODO dynamisch fuellen
     APPOINTMENTLIST = [
    { :priority_number => 3, :date => "24.01.2012", :category => "singaporean", :note => "Fish Head Curry", :group => "Little India" },
    { :priority_number => 3, :date => "24.01.2012",:category => "singaporean", :note  => "Pig Organ Soup", :group => "Food Court" },
    { :priority_number =>8, :date => "24.01.2012",:category => "indian", :note => "Chicken Biryani", :group => "Al Ameen's" },
    { :priority_number =>9, :date => "24.01.2012",:category => "german", :note => "Pork Knuckle", :group => "Stammtisch Restaurant" },
    { :priority_number =>10, :date => "24.01.2012",:category => "indian", :note => "Butter Chicken", :group => "Jaggi's Northern Indian Cuisine" },
    { :priority_number =>10, :date => "24.01.2012",:category => "indian", :note => "Chicken Tikka", :group => "Jaggi's Northern Indian Cuisine" },
    { :priority_number =>7,:date => "24.01.2012", :category => "singaporean", :note => "Mutton Murtabak", :group => "Zam Zam Restaurant" },
    { :priority_number =>8,:date => "24.01.2012", :category => "singaporean", :note => "Chicken Murtabak", :group => "Ah Mei Kaya Toast" },
    { :priority_number =>9, :date => "24.01.2012",:category => "western", :note => "Beef Cheek", :group => "Ember Restaurant" },
    { :priority_number =>8,:date => "24.01.2012", :category => "western", :note => "Cowboy Burger", :group => "Brewerkz" },
    { :priority_number =>8,:date => "24.01.2012", :category => "mexican", :note => "Pork Enchilada", :group => "Iguana Cafe" }
  ]

  helper_method :sort_column, :sort_direction, :selected_friend


  attr_accessor :friends_array

  def index
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

    #hasha = Hash.new()
    final = Array.new
    @appointments.each do |appointment|
    zw = {:appointment => {:id => appointment.id,:priority => appointment.priority_number, :groupe => appointment.group_id, :date => appointment.start_at, :note => appointment.note } }
    #hasha[appointment] = zw
    final.push(zw)
    end

    if File.exists?("./datein/allXML") then
      File.delete("./datein/allXML")
    end

    dats = File.new("./datein/allXML", "a")
    dats.write(final.to_xml)
    dats.close()
   #dats = File.new("./datein/AppointmentToXML42222", "a")
    #dats.write(hasha.to_xml)
    #dats.close()

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @appointments }
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


  # GET /appointments/1
  # GET /appointments/1.json

  def show
    @group = Group.new
    @groups = Group.find(:all, :conditions => {:user_id => current_user})

    @users= User.all
    @shared_friendships = FriendshipAppointment.all
    @shared_friendship = FriendshipAppointment.new

    @appointment = Appointment.find(params[:id])

    single = {:appointment => {:id => @appointment.id,:priority => @appointment.priority_number, :groupe => @appointment.group_id, :date => @appointment.start_at, :note => @appointment.note } }
    if File.exists?("./datein/temp/singleXML") then File.delete("./datein/temp/singleXML") end  # zum saubern der datei
    dats = File.new("./datein/temp/singleXML", "a")
    dats.write(single.to_xml)
    dats.close()

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @appointment }
      format.xml { render :xml => @appointment, :location => @appointment }
    end
  end

  # GET /appointments/new
  # GET /appointments/new.json
  def new
    @group = Group.new
    @groups = Group.find(:all, :conditions => {:user_id => current_user})

    @shared_friendships = FriendshipAppointment.all
    @shared_friendship = FriendshipAppointment.new

    @appointment = Appointment.new
    #@appointment.user_id = current_user.id
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @appointment }
      format.xml {render :xml => @appointment}
    end

  end



  # GET /appointments/1/edit
  def edit

    @group = Group.new
    @groups = Group.find(:all, :conditions => {:user_id => current_user})
    @shared_friendships = FriendshipAppointment.all
    @shared_friendship = FriendshipAppointment.new
    @appointment = Appointment.find(params[:id])
    @appointment.color = @appointment.group.colour
    respond_to { |format|
      format.html
      format.xml { render :xml => @appointment } }
  end

  # POST /appointments
  # POST /appointments.json
  def create

      @appointment = Appointment.new(params[:appointment].merge(:user =>current_user)) #user id mit user verknüpfen
      @appointment.color = @appointment.group.colour
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
    @appointment.color = @appointment.group.colour
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
  # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -
 def send_xml_file
    aFile = File.new("./datein/allXML", "r")
    aFile.close
    send_file("./datein/allXML") and return

 end
  # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -
  def send_xml_file_single
    aFile = File.new("./datein/temp/singleXML", "r")
    send_file("./datein/temp/singleXML")
    aFile.close
  end
  # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -
  def show_with_xml
    @appointment = Appointment.find(params[:id])
    out_data << @appointment.to_xml.to_s
    #send_data(@appointment.toxml, :disposition => "inline")
    send_data( out_data, :type => "text/xml", :filename => "appointment #{@appointment.id}.xml", :disposition => "inline")
    #hijack_response_inline( generate_rexml )
  end

  # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -
  def show_with_xml_single
    #single = File.new("./datein/temp/singleXML", "r")
    @appointment = Appointment.find(params[:id])

   #redirect_to "#{appointment_url}.xml"
     render :partial => 'appointments/xml', :locals => {:apps => @appointment}


      #FriendshipAppointment.where(:appointment_id => @appointment.id).update_all(:user =>current_user)

  end
  # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -
  def show_with_rexml_single
    single = File.new("./datein/temp/singleXML", "r")
    #send_data("./datein/temp/singleXML", :disposition => "inline")
       @appointments = Appointment.find(:all)

    hash = @appointments
       doc = REXML::Document.new
       root = doc.add_element( "Kalender" )
       hash.each{ |element_data|

         hash_element = root.add_element( "Termin" )

          hash_element.add_attribute( "Gruppe", element_data[:group_id] )
          hash_element.add_attribute( "Prioritaet", element_data[:priority_number] )

          hash_note_element = hash_element.add_element( "Notiz" )
          hash_note_element.add_text( element_data[:note] )

         hash_date_element = hash_element.add_element( "Date" )
         hash_date_element.add_text( element_data[:start_at].to_s )
       }
       doc.write( out_string = "", 2 )
      send_data( out_string, :type => "text/xml", :filename => "appointment #{@appointment.id}.xml", :disposition => "inline")
    #hijack_response_inline(single)
  end
  # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -
  #TODO
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
  # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -
  def generate_with_rexml2
    hijack_response( inapphash )
  end





def dump_csv
  @appointments = Appointment.find(:all, :order => "id ASC")
  @outfile = "appointment_" + Time.now.strftime("%m-%d-%Y") + ".csv"

  csv_data = FasterCSV.generate do |csv|
    csv << [
    "start at",
    "updated_at",
    "end_at",
    "note",
    "group",
    "priority_number"
    ]
    @appointments.each do |appointment|
      csv << [
     appointment.start_at,
      appointment.updated_at,
      appointment.end_at,
     appointment.note,
     appointment.group,
     appointment.priority_number
      ]
    end
  end

  send_data csv_data,
    :type => 'text/csv; charset=iso-8859-1; header=present',
    :disposition => "attachment; filename=#{@outfile}"

  flash[:notice] = "Export complete!"
end

  #########################
  private
 # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -

  # @param out_data [Object]
  def hijack_response( out_data )

    send_data( out_data, :type => "text/xml", :filename => "outline.xml")

  end

  def hijack_response_inline( out_data )

    send_data( out_data, :type => "text/xml", :filename => "inline.xml", :disposition => "inline")

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
       appointmentlist_note_element.add_text( element_data[:note] )

      date_element = appointmentlist_element.add_element( "Date" )
      date_element.add_text( element_data[:date] )
    }
    doc.write( out_string = "", 2 )
    return out_string
  end



  # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -

  #def parse_with_rexml( xml_data )
  #  doc = REXML::Document.new( xml_data )
  #  REXML::XPath.each( doc, "//AppointmentlistNote" ){ |appointmentlist_note_element|
  #   if appointmentlist_note_element.text == "Fish Head Curry" or appointmentlist_note_element.text == "Pig Organ Soup"
  #     parent = appointmentlist_note_element.parent
  #     parent.attributes["priority_number"] = 6
  #   end
  #  }
   # doc.write( out_string = "", 2 )
  #  hijack_response( out_string )
 # end
  # - - - - - - - - - - - - - - - - - - - - - - - -
  # - - - - - - - - - - - - - - - - - - - - - - - -
  #TODO needs work
  def inapphash
    doc = REXML::Document.new
    root = doc.add_element( "Agenda" )


    LISTE.each{ |element_data|

      liste_element = root.add_element( "Appoitnment" )

       liste_element.add_attribute( "Identifikation", element_data[:id] )
       #appointments_element.add_attribute( "priority_number", element_data[:priority_number] )
      liste_priority_element = liste_element.add_element("priority")
      liste_priority_element.add_text(element_data[:priority])

      liste_note_element = liste_element.add_element( "note" )
      liste_note_element.add_text( element_data[:note] )

      date_element = liste_element.add_element( "Start at" )
      date_element.add_text( element_data[:date] )
    }
    doc.write( out_string = "", 2 )
    return out_string
  end
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
