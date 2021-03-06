class GroupsController < ApplicationController
  before_filter :require_user, :only  => [:edit, :index, :new , :show , :destroy]


  # GET /groups
  # GET /groups.json
  def index

    @group = Group.new

     if current_user.admin?
      #admin darf alle Gruppen sehen und verwalten und nach user sortieren
       @groups = Group.all

    else
      #wenn der User kein Admin ist, werden nur com user angelegte Gruppen gezeigt
      @groups = Group.find(:all, :conditions => {:user_id => current_user})


    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @group = Group.find(params[:id])
    @groups = Group.find(:all, :conditions => {:user_id => current_user})

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.json
  def new
    @group = Group.new

    respond_to do |format|
      flash[:notice] = 'Group saved.'
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(params[:group])
    @group = Group.new(params[:group].merge(:user_id =>current_user.id)) #user id mit user verknüpfen
    respond_to do |format|
      if @group.save
        flash[:notice] = 'Group "' + @group.name + '" saved.'
        format.html { redirect_to :action => :index, :controller => :appointments }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.json
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to appointments_path, notice: 'Group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :ok }
    end
  end
end
