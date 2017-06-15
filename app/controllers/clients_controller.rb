class ClientsController < ApplicationController
  before_action :login_required
  before_action :find_and_set_client, only: [:show, :edit, :appointment_complete, :update_progress, :update, :destroy]

  def index
    @clients = current_user.clients
  end

  def new
    @client = current_user.clients.build
    @appointment = @client.appointments.build
  end

  def create
    @client =  Client.new(client_params)
    @client.appointments.update(user_id: current_user.id)
    if @client.save
      @client.weight_histories.create(weight_recording: 0)
      redirect_to clients_path
    else
      # Bug: fields_for :appointments does not appear when rendering :new after
      # validation error, even after setting @appointment = @client.appointments.build
      # at this point in the method.
      redirect_to new_client_path, alert: "Error(s): #{@client.errors.full_messages.join(', ')}."
    end
  end

  def show
  end

  def edit
  end

  def appointment_complete
  end

  def update_progress
    @current_weight = @client.weight
    if @client.update(client_params)
      if @client.completed_appointments != 0
        @client.document_progress(client_params[:weight].to_i, @current_weight)
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
    @client.weight_histories.destroy
    @client.destroy
    redirect_to clients_path, alert: "Client removed."
  end

  private

  def find_and_set_client
    @client = current_user.clients.find_by(id: params[:id])
    if @client.nil?
      redirect_to clients_path, alert: "Client not found."
    end
  end

  def client_params
    params.require(:client).permit(:id, :name, :email, :phone, :age, :weight, :goal, :weight_change, :appointments_attributes => [
      :id,
      :user_id,
      :client_id,
      :date
      ])
  end
end
