class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.integer :user_id
      t.integer :client_id
      t.datetime :date
    end
  end
end
