class AddDefaultValueToWeightChange < ActiveRecord::Migration[5.0]
  def change
    change_column :clients, :weight_change, :integer, :default => 0, null: false
  end
end
