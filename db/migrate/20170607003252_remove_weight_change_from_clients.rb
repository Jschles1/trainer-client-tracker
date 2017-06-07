class RemoveWeightChangeFromClients < ActiveRecord::Migration[5.0]
  def change
    remove_column :clients, :weight_change
  end
end
