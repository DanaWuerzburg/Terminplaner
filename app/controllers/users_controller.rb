class UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  #before_filter :require_user, :only => [:index, :edit, :update ,:show]
  before_filter :require_admin    ,:only =>   [:index]




  # GET /users
  # GET /users.json
  def index
    @group = Group.new
    @groups = Group.find(:all, :conditions => {:user_id => current_user})

    @users = User.all
    @user = current_user

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @group = Group.new
    @groups = Group.find(:all, :conditions => {:user_id => current_user})

    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @group = Group.new
    @groups = Group.find(:all, :conditions => {:user_id => current_user})
    @user = User.find(params[:id])

  end

  # POST /users
    # POST /users.json
  # new create method:
  def create
    @user = User.new(params[:user])

    # Saving without session maintenance to skip
    # auto-login which can't happen here because
    # the User has not yet been activated
    if @user.save_without_session_maintenance
      @user.send_activation_instructions!      # new method in the User model

      @user.create_no_group
      flash[:notice] = "Please confirm your account by following the instructions we've sent to your " + @user.email + " email address."
      redirect_to new_user_session_url
    else

    end
  end

  def activate
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)

    raise Exception if @user.active?

    if @user.activate!
      UserSession.create(@user)#UserSession.create(@user, false)
      @user.send_activation_confirmation!
      flash[:notice] = "Your account has been activated."
      redirect_to root_url
    else

      render :action => :new
    end
  end



  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to appointments_path, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

end
