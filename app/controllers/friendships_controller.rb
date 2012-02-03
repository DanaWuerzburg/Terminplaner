class FriendshipsController < ApplicationController
  # GET /friendships
  # GET /friendships.json
  def index
    @group = Group.new
    @groups = Group.find(:all, :conditions => {:user_id => current_user})

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
    @group = Group.new
    @groups = Group.find(:all, :conditions => {:user_id => current_user})


   # redirect_to user_path(current_user)
   # @friendship1 = Friendship.find(params[:id])
    @friend = User.find(params[:id])
    @users = User.all
   # ###### redirect to appointments      ######
    respond_to do |format|
      format.html
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
    #@friendship = current_user.friendships.build(:friend_id => params[:friend_id])

    @user = User.find(current_user)
    @friend = User.find(params[:friend_id])
    params[:friendship1] = {:user_id => @user.id, :friend_id => @friend.id, :status => 'requested'}
    params[:friendship2] = {:user_id => @friend.id, :friend_id => @user.id, :status => 'pending'}
    @friendship1 = Friendship.create(params[:friendship1])
    @friendship2 = Friendship.create(params[:friendship2])

    if @friendship1.save && @friendship2.save
      flash[:notice] = "You sent a friend request to " + @friend.login + "."
      redirect_to friendships_path
    else
      flash[:error] = "Unable to sent a friend request to " + @friend.login + "."
      redirect_to friendships_path
    end

    #if @friendship.save
    #  flash[:notice] = "You sent a friend request to " + @friend.login + "."
    #  redirect_to root_url
    #else
    #  flash[:error] = "Unable to sent a friend request to " + @friend.login + "."
    #  redirect_to root_url
    #end

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
      flash[:notice] = "You are now friends with " + @friend.login + "."
      redirect_to appointments_path
    else
      redirect_to appointments_path
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

    @user = User.find(current_user)
    @friend = User.find(params[:id])
    @friendship1 = @user.friendships.find_by_friend_id(params[:id]).destroy
    @friendship2 = @friend.friendships.find_by_user_id(params[:id]).destroy


    flash[:notice] = "You cancelled your friend request to " + @friend.login + "."
    redirect_to friendships_path

    #@friendship = current_user.friendships.find(params[:id])
    #@friendship.destroy
    #flash[:notice] = "You are not friends with " + @friend.login + " anymore."
    #redirect_to current_user

    #@friendship = Friendship.find(params[:id])
    #@friendship.destroy
    #
    #respond_to do |format|
    #  format.html { redirect_to friendships_url }
    #  format.json { head :ok }
    #end

  end
end
