class AppointmentsController < ApplicationController
  def index
    @appointments = current_user.appointments
  end

  def edit
    @appointment = current_user.appointments.find(params[:id])
  end

  def update
    @appointment = current_user.appointments.find(params[:id])
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
