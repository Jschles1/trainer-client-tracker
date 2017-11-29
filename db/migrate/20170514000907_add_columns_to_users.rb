class AddColumnsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :oauth_token, :text
    add_column :users, :oauth_expires_at, :datetime
  end
end
