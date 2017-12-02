class AppointmentsController < ApplicationController
  before_action :login_required

  # Render current user's appointments to the dashboard via AJAX
  def index
    @appointments = current_user.appointments
    render json: @appointments
  end

  # Appointment edit form
  def edit
    @client = current_user.clients.find_by(id: params[:client_id])
    if @client.nil?
      redirect_to dashboard_path, alert: "Client not found."
    else
      @appointment = @client.appointments.find_by(id: params[:id])
      redirect_to dashboard_path, alert: "Appointment not found." if @appointment.nil?
    end
  end

  # Submission of appointment edit form
  def update
    @appointment = current_user.appointments.find_by(id: params[:id])
    if @appointment.update(appointment_params)
      redirect_to dashboard_path, alert: "Appointment Updated."
    else
      render :edit
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :user_id, :client_id)
  end
end
