class AddProgressToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :progress, :integer, default: 0
  end
end
