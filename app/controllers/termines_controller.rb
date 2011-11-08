class TerminesController < ApplicationController
  # GET /termines
  # GET /termines.json
  def index
    @termines = Termine.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @termines }
    end
  end

  # GET /termines/1
  # GET /termines/1.json
  def show
    @termine = Termine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @termine }
    end
  end

  # GET /termines/new
  # GET /termines/new.json
  def new
    @termine = Termine.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @termine }
    end
  end

  # GET /termines/1/edit
  def edit
    @termine = Termine.find(params[:id])
  end

  # POST /termines
  # POST /termines.json
  def create
    @termine = Termine.new(params[:termine])

    respond_to do |format|
      if @termine.save
        format.html { redirect_to @termine, notice: 'Termine was successfully created.' }
        format.json { render json: @termine, status: :created, location: @termine }
      else
        format.html { render action: "new" }
        format.json { render json: @termine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /termines/1
  # PUT /termines/1.json
  def update
    @termine = Termine.find(params[:id])

    respond_to do |format|
      if @termine.update_attributes(params[:termine])
        format.html { redirect_to @termine, notice: 'Termine was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @termine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /termines/1
  # DELETE /termines/1.json
  def destroy
    @termine = Termine.find(params[:id])
    @termine.destroy

    respond_to do |format|
      format.html { redirect_to termines_url }
      format.json { head :ok }
    end
  end
end
