class NotesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:index, :show, :search]

  # GET /notes
  # GET /notes.json
  def index
    if user_signed_in?
      @notes = current_user.notes.paginate :page => params[:page]
    else
      @notes = Note.paginate :page => params[:page]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notes }
    end
  end

  def search
    @keywords = params[:keywords]

    if user_signed_in?
      @notes = current_user.notes.search(@keywords).paginate :page => params[:page]
    else
      @notes = Note.search(@keywords).paginate :page => params[:page]
    end

    render :index
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.json
  def new
    @note = Note.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(params[:note])
    @note.user = current_user

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render json: @note, status: :created, location: @note }
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.json
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end
end
