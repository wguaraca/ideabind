class RemoveIndexIdeaIdFromUpdates < ActiveRecord::Migration
  def change
    remove_index :updates, :idea_id
    add_index :updates, :idea_id, unique: false
  end
end
