class AppointmentsController < ApplicationController
  def index
    @appointments = current_user.appointments
  end

  def new
    @appointment = Appointment.new
    @appointment.client.build
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def appointment_params
    params.require(:appointment).permit(:date, :client_attributes => [
      :name,
      :email,
      :phone,
      :age,
      :weight,
      :goal,
      :weight_change
      ])
  end
end
