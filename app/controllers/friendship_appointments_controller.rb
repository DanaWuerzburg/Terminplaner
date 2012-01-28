class FriendshipAppointmentsController < ApplicationController
  # GET /friendship_appointments
  # GET /friendship_appointments.json
  def index
    @friendship_appointments = FriendshipAppointment.all
    @users= User.all
       # @user = User.find(params[:user_id])


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @friendship_appointments }
    end
  end

  # GET /friendship_appointments/1
  # GET /friendship_appointments/1.json
  def show
   # redirect_to user_path(current_user)
   # @friendship1 = Friendship.find(params[:id])
    @shared_friend = User.find(params[:id])
    @users = User.all
   # ###### redirect to appointments      ######
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @friendship_appointment }
    end
  end

  # GET /friendship_appointments/new
  # GET /friendship_appointments/new.json
  def new
    @friendship1 = Friendship.new
    @friendship2 = Friendship.new
  end

  # GET /friendship_appointments/1/edit
  def edit
    @friendship_appointment = FriendshipAppointment.find(params[:id])
  end


  # POST /friendship_appointments
  # POST /friendship_appointments.json
  def create

    @user = User.find(current_user)
    @appointent = Appointment.find(current_appointment)
       @shared_friend = User.find(params[:shared_friend_id])
       params[:friendship1] = {:user_id => current_user.id, :shared_friend_id => @shared_friend.id,:appointment_id => @appointment.id}
       params[:friendship2] = {:user_id => @shared_friend.id, :shared_friend_id => current_user.id,:appointment_id => @appointment.id,}
       @friendship1 = Friendship.create(params[:friendship1])
       @friendship2 = Friendship.create(params[:friendship2])


    if @friendship1.save && @friendship2.save
      flash[:notice] = "Added friend to appointment."
      #redirect_to appointments_path
    else
      flash[:error] = "Unable to add friend to appointment."
      #redirect_to appointments_path
    end

  end

  # PUT /friendship_appointments/1
  # PUT /friendship_appointments/1.json
  def update

    @user = User.find(current_user)
    @shared_friend = User.find(params[:id])
    params[:friendship1] = {:user_id => @user.id, :shared_friend_id => @shared_friend.id}
    params[:friendship2] = {:user_id => @shared_friend.id, :shared_friend_id => @user.id}
    @friendship1 = Friendship.find_by_user_id_and_friend_id(@user.id, @shared_friend.id)
    @friendship2 = Friendship.find_by_user_id_and_friend_id(@shared_friend.id, @user.id)

    if @friendship1.update_attributes(params[:friendship1]) && @friendship2.update_attributes(params[:friendship2])
      flash[:notice] = 'Appointment friend sucessfully updated!'
      redirect_to appointments_path
    else
      redirect_to appointments_path
    end
  end

  # DELETE /friendship_appointments/1
  # DELETE /friendship_appointments/1.json
  def destroy

    @user = User.find(current_user)
    @shared_friend = User.find(params[:id])
    @friendship1 = @user.friendships.find_by_friend_id(params[:id]).destroy
    @friendship2 = @shared_friend.friendships.find_by_user_id(params[:id]).destroy
    redirect_to appointments_path

  end

end
