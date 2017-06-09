module ClientHelper

  def client_name(client)
    if current_page?(clients_path)
      link_to client.name, client_path(client)
    else
      client.name
    end
  end

  def appointment_fields(form, client, appointment)
    if current_page?(new_client_path) || current_page?(appointment_complete_path(client))
      render partial: "appointment_fields", locals: {f: form, appointments: appointment, client: client}
    end
  end

  def appointment_field_label(appointment, client)
    if current_page?(new_client_path)
      appointment.label :date, "Schedule First Appointment:"
    elsif current_page?(appointment_complete_path(client))
      appointment.label :date, "Schedule Next Appointment:"
    end
  end

  def client_progress(client)
    if client.progress != 0
      case client.goal
      when "Lose Weight"
        content_tag(:h4, "#{client_name(client)} has lost #{client.progress} lbs. since your first appointment.")
      when "Gain Weight"
        content_tag(:h4, "#{client_name(client)} has gained #{client.progress} lbs. since your first appointment.")
      end
    end
  end

  def most_dedicated_client(clients)
    clients.most_dedicated.name if clients.most_dedicated != nil
  end

  def most_progressed_client(clients)
    clients.most_progress.name if clients.most_progress != nil
  end
end
