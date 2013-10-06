class RemoveIndexingFromComments < ActiveRecord::Migration
  def change
  	remove_index :comments, [:idea_id, :update_id]
  	add_index :comments, :idea_id
  	add_index :comments, :update_id
  end
end
