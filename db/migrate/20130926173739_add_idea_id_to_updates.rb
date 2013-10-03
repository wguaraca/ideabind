class AddIdeaIdToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :idea_id, :integer
    add_index :updates, :idea_id, unique: true
  end
end
