class AddProfileIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_id, :string
    add_index :users, :profile_id, unique: true
  end
end
