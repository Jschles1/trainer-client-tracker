class AppointmentsController < ApplicationController
  def index
    @appointments = current_user.appointments
  end

  def new
    @appointment = Appointment.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
