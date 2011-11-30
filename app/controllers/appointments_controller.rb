class AppointmentsController < ApplicationController
  # GET /appointments
  # GET /appointments.json

  helper_method :sort_column, :sort_direction

  def index
   # @appointments = Appointment.order("date DESC").all        # model alle einträge der datenbank
    # .order("date DESC")   zum ordnen der inhalte nach datum
    @appointments = Appointment.order(sort_column + " " + sort_direction)
   # @appointments= Appointment.all
    @appointment = Appointment.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @appointments, :notice => 'Appointment in index.' }
    end
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
    @appointment = Appointment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @appointment, :notice => 'Appointment in new' }
    end
    render 'erstellt'
  end

  # GET /appointments/1/edit
  def edit
    @appointment = Appointment.find(params[:id])
  end

  # POST /appointments
  # POST /appointments.json
  def create
      @appointment = Appointment.new(params[:appointment])
      if @appointment.save
        flash[:notice] = 'Der Termin wurde hinzugefuegt '
        redirect_to :action => :index and return
      end
    else
    render :text => "MIST"
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
