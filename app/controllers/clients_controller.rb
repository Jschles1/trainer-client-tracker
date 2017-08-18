class ClientsController < ApplicationController
  before_action :login_required
  before_action :find_and_set_client, only: [:show, :edit, :appointment_complete, :update_progress, :update, :destroy]

  def index
    @clients = current_user.clients
    respond_to do |f|
      f.html { render :index }
      f.json { render json: @clients }
    end
  end

  def new
    @client = Client.new
    @appointment = @client.appointments.build
  end

  def create
    @client =  Client.new(client_params)
    @client.appointments.update(user_id: current_user.id)
    if @client.save
      redirect_to client_path(@client)
    else
      redirect_to new_user_client_path(current_user), alert: "Error(s): #{@client.errors.full_messages.join(', ')}."
    end
  end

  def show
    @note = Note.new
    @notes = @client.notes if @client.notes
    respond_to do |f|
      f.html { render :show }
      f.json { render json: @client }
    end
  end

  def edit
  end

  def appointment_complete
  end

  def update_progress
    @old_weight = @client.weight
    if @client.update(client_params)
      if @client.completed_appointments != 0
        @client.document_progress(client_params[:weight].to_i, @old_weight)
        @client.update_progress
      end
      @client.complete_appointment
      redirect_to client_path(@client)
    else
      render :appointment_complete
    end
  end

  def update
    if @client.update(client_params)
      redirect_to client_path(@client)
    else
      render :edit
    end
  end

  def destroy
    @client.appointments.destroy_all
    @client.weight_histories.destroy_all
    @client.destroy
    redirect_to dashboard_path, alert: "Client removed."
  end

  private

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
