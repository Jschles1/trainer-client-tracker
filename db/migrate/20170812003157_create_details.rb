class CreateDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :details do |t|
      t.string :text
      t.references :client, foreign_key: true
    end
  end
end
