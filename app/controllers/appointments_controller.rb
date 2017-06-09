class AppointmentsController < ApplicationController
  def index
    @appointments = current_user.appointments
  end

  def edit
    @client = current_user.clients.find_by(id: params[:client_id])
    if @client.nil?
      redirect_to appointments_path, alert: "Client not found."
    else
      @appointment = @client.appointments.find_by(id: params[:id])
      redirect_to appointments_path, alert: "Appointment not found." if @appointment.nil?
    end
  end

  def update
    @appointment = current_user.appointments.find_by(id: params[:id])
    if @appointment.update(appointment_params)
      redirect_to appointments_path
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :user_id, :client_id)
  end
end
