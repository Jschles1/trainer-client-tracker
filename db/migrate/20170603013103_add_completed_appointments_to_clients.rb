class AddCompletedAppointmentsToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :completed_appointments, :integer, default: 0
  end
end
