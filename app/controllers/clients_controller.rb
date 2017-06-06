class ClientsController < ApplicationController
  before_action :login_required

  def index
    @clients = current_user.clients
  end

  def new
    @client = current_user.clients.build
    @client.appointments.build
  end

  def create
    @client =  Client.new(client_params)
    @client.appointments.update(user_id: current_user.id)
    if @client.save
      redirect_to clients_path
    else
      render :new
    end
  end

  def show
    @client = current_user.clients.find(params[:id])

  end

  def edit
    @client = current_user.clients.find(params[:id])
  end

  def appointment_complete
    @client = current_user.clients.find(params[:id])
  end

  def update_progress
    @client = current_user.clients.find(params[:id])
    if @client.valid?
      @client.document_progress(client_params[:weight].to_i)
      @client.update(client_params)
      @client.complete_appointment
      redirect_to client_path(@client)
    else
      render :appointment_complete
    end
  end

  def update
    @client = current_user.clients.find(params[:id])
    if @client.update(client_params)
      redirect_to client_path(@client)
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def client_params
    params.require(:client).permit(:id, :name, :email, :phone, :age, :weight, :goal, :weight_change, :appointments_attributes => [
      :id,
      :user_id,
      :client_id,
      :date
      ])
  end
end
