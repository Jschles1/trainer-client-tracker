module ClientHelper

  def client_name(client)
    if current_page?(clients_path)
      link_to client.name, client_path(client)
    else
      client.name
    end
  end

  def most_dedicated_client(clients)
    clients.most_dedicated.name
  end

  def most_progressed_client(clients)
    clients.most_progress.name
  end
end
