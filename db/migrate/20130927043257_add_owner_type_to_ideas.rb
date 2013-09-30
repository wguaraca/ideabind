class AddOwnerTypeToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :owner_type, :string
  end
end
