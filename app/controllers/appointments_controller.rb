class AppointmentsController < ApplicationController
  before_action :login_required

  def index
    @appointments = current_user.appointments
  end

  def edit
    @client = current_user.clients.find_by(id: params[:client_id])
    if @client.nil?
      redirect_to user_appointments_path(current_user), alert: "Client not found."
    else
      @appointment = @client.appointments.find_by(id: params[:id])
      redirect_to user_appointments_path(current_user), alert: "Appointment not found." if @appointment.nil?
    end
  end

  def update
    @appointment = current_user.appointments.find_by(id: params[:id])
    if @appointment.update(appointment_params)
      redirect_to user_appointments_path(current_user)
    else
      render :edit
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :user_id, :client_id)
  end
end
