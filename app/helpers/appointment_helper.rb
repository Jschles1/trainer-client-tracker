module AppointmentHelper

  # Format date using .strftime
  def date_parse(appointment)
    appointment.date.strftime("%b %e, %l:%M %p")
  end

end