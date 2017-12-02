class ClientsController < ApplicationController
  before_action :login_required
  before_action :find_and_set_client, only: [:show, :edit, :appointment_complete, :update_progress, :update, :destroy]

  # Render current user's clients to the dashboard via AJAX
  def index
    @clients = current_user.clients
    render json: @clients
  end

  # New Client form
  def new
    @client = Client.new
    @appointment = @client.appointments.build
  end

  # New Client form submission
  def create
    # Create new client object, with nested appointment object
    @client =  Client.new(client_params)
    # Set the new appointment's user_id equal to the current_user's id. This completes the association
    # between the current user and client, with the appointment acting as a join table
    @client.appointments.update(user_id: current_user.id)
    if @client.save
      redirect_to client_path(@client)
    else
      redirect_to new_user_client_path(current_user), alert: "Error(s): #{@client.errors.full_messages.join(', ')}."
    end
  end

  # Client Show page
  def show
    # Create new note object for AJAX note form
    @note = Note.new
    # Get notes belonging to client if any exist
    @notes = @client.notes if @client.notes
    # Can be rendered via html or AJAX
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @client }
    end
  end

  # Client Edit page
  def edit
  end

  # Action triggered when "Appointment Complete" button is clicked
  def appointment_complete
  end

  # Submission of appointment_complete form
  def update_progress
    # Store previous weight in @old_weight before updating
    @old_weight = @client.weight
    if @client.update(client_params)
      # Start documenting progress once client has completed > 1 appointment
      if @client.completed_appointments != 0
        @client.document_progress(client_params[:weight].to_i, @old_weight)
        @client.update_progress
      end
      # Add 1 to client's completed appointments
      @client.complete_appointment
      redirect_to client_path(@client)
    else
      render :appointment_complete
    end
  end

  # Submission of client edit form
  def update
    if @client.update(client_params)
      redirect_to client_path(@client)
    else
      render :edit
    end
  end

  # Remove client and associated resources from db
  def destroy
    @client.appointments.destroy_all
    @client.weight_histories.destroy_all
    @client.destroy
    redirect_to dashboard_path, alert: "Client removed."
  end

  private

  # Finds client in db belonging to current user based on url parameters
  def find_and_set_client
    @client = current_user.clients.find_by(id: params[:id])
    if @client.nil?
      redirect_to dashboard_path, alert: "Client not found."
    end
  end

  def client_params
    params.require(:client).permit(:id, :name, :email, :phone, :age, :weight, :goal, :appointments_attributes => [
      :id,
      :user_id,
      :client_id,
      :date
      ])
  end
end
