class FriendshipsController < ApplicationController
  # GET /friendships
  # GET /friendships.json
  def index
    @friendships = Friendship.all
    @users= User.all
   # @user = User.find(params[:user_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @friendships }
    end
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show
    @friendship = Friendship.find(params[:id])
    redirect_to  root_path
    ###### redirect to appointments      ######
    respond_to do |format|
      format.html { redirect_to :appointments, notice: 'User was successfully updated.' }
      format.json { render json: @friendship }
    end
  end

  # GET /friendships/new
  # GET /friendships/new.json
  def new
    #@friendship = Friendship.new
    @friendship1 = Friendship.new
    @friendship2 = Friendship.new
    #respond_to do |format|
    #  format.html # new.html.erb
    #  format.json { render json: @friendship }
    #end
  end



  # POST /friendships
  # POST /friendships.json
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
  if @friendship.save
    flash[:notice] = "Added friend."
    redirect_to root_url
  else
    flash[:error] = "Unable to add friend."
    redirect_to root_url
  end

   # @friendship = Friendship.new(params[:friendship])
   #
   # respond_to do |format|
   #   if @friendship.save
   #     format.html { redirect_to @friendship, notice: 'Friendship was successfully created.' }
   #     format.json { render json: @friendship, status: :created, location: @friendship }
   #   else
   #     format.html { render action: "new" }
   #     format.json { render json: @friendship.errors, status: :unprocessable_entity }
   #   end
   # end
  end

  # PUT /friendships/1
  # PUT /friendships/1.json
  def update
    @user = User.find(current_user)
    @friend = User.find(params[:id])
    params[:friendship1] = {:user_id => @user.id, :friend_id => @friend.id, :status => 'accepted'}
    params[:friendship2] = {:user_id => @friend.id, :friend_id => @user.id, :status => 'accepted'}
    @friendship1 = Friendship.find_by_user_id_and_friend_id(@user.id, @friend.id)
    @friendship2 = Friendship.find_by_user_id_and_friend_id(@friend.id, @user.id)

    if @friendship1.update_attributes(params[:friendship1]) && @friendship2.update_attributes(params[:friendship2])
      flash[:notice] = 'Friend sucessfully accepted!'
      redirect_to user_friends_path(current_user)
    else
      redirect_to user_path(current_user)
    end
    #@friendship = Friendship.find(params[:id])
    #
    #respond_to do |format|
    #  if @friendship.update_attributes(params[:friendship])
    #    format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
    #    format.json { head :ok }
    #  else
    #    format.html { render action: "edit" }
    #    format.json { render json: @friendship.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to current_user

    #@friendship = Friendship.find(params[:id])
    #@friendship.destroy
    #
    #respond_to do |format|
    #  format.html { redirect_to friendships_url }
    #  format.json { head :ok }
    #end
  end
end
