class CreateWeightHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :weight_histories do |t|
      t.references :client, foreign_key: true
      t.integer :weight_recording

      t.timestamps
    end
  end
end
