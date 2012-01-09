class PasswordResetsController < ApplicationController
  # GET /password_resets
  # GET /password_resets.json
  def index
    @password_resets = PasswordReset.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @password_resets }
    end
  end

  # GET /password_resets/1
  # GET /password_resets/1.json
  def show
    @password_reset = PasswordReset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @password_reset }
    end
  end

  # GET /password_resets/new
  # GET /password_resets/new.json
  def new
    @password_reset = PasswordReset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @password_reset }
    end
  end

  # GET /password_resets/1/edit
  def edit
    @password_reset = PasswordReset.find(params[:id])
  end

  # POST /password_resets
  # POST /password_resets.json
  def create
    @password_reset = PasswordReset.new(params[:password_reset])

    respond_to do |format|
      if @password_reset.save
        format.html { redirect_to @password_reset, notice: 'Password reset was successfully created.' }
        format.json { render json: @password_reset, status: :created, location: @password_reset }
      else
        format.html { render action: "new" }
        format.json { render json: @password_reset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /password_resets/1
  # PUT /password_resets/1.json
  def update
    @password_reset = PasswordReset.find(params[:id])

    respond_to do |format|
      if @password_reset.update_attributes(params[:password_reset])
        format.html { redirect_to @password_reset, notice: 'Password reset was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @password_reset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /password_resets/1
  # DELETE /password_resets/1.json
  def destroy
    @password_reset = PasswordReset.find(params[:id])
    @password_reset.destroy

    respond_to do |format|
      format.html { redirect_to password_resets_url }
      format.json { head :ok }
    end
  end
end
