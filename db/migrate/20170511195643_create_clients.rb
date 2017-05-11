class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :age
      t.integer :weight
      t.string :goal
    end
  end
end
