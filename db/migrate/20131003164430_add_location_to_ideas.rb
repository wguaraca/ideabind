class AddLocationToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :location, :string
    add_index :ideas, :location
  end
end
