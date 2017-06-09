module ClientHelper

  def client_name(client)
    if current_page?(clients_path)
      link_to client.name, client_path(client)
    else
      client.name
    end
  end

  def client_progress(client)
    if client.weight_histories != nil
      content_tag(:h3, "Progress:")
      content_tag(:br)
      if client.goal == "Lose Weight"
        content_tag(:h4, "#{client_name(client)} has lost #{client.progress} lbs. since your first appointment.")
      elsif client.goal == "Gain Weight"
        content_tag(:h4, "#{client_name(client)} has gained #{client.progress} lbs. since your first appointment.")
      end
    end
  end

  def most_dedicated_client(clients)
    clients.most_dedicated.name
  end

  def most_progressed_client(clients)
    clients.most_progress.name
  end
end
