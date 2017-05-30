class AppointmentsController < ApplicationController
  def index
    @appointments = current_user.appointments
  end

  def new
    @appointment = Appointment.new
    @appointment.build_client
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
    params.require(:appointment).permit(:date, :user_id, :client_id, :client_attributes => [
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
