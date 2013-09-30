class AddOwnerIdToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :owner_id, :integer
    add_index :ideas, :owner_id
  end
end
