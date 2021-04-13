class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy assign_user remove_user ]
  before_action :set_user, only: %i[ assign_user remove_user ]

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
    render
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    render
  end

  # POST /events/1/assign_user
  def assign_user
    return redirect_to @event, alert: "User already exist" if @event.users.exists?(@user.id)
    @event.users << @user
    respond_to do |format|
      format.js
    end
  end

  def remove_user
    @event.users.delete(@user)
    respond_to do |format|
      format.js
    end
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      begin
        @event = Event.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        return redirect_to events_path, alert: 'Record not found'
      end
    end

    def set_user
      begin
        @user = User.find(params[:user_id])
      rescue ActiveRecord::RecordNotFound => e
        return redirect_to events_path, alert: 'Record not found'
      end
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:name, :date)
    end
end
