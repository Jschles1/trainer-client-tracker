class AddWeightChangeToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :weight_change, :integer
  end
end
