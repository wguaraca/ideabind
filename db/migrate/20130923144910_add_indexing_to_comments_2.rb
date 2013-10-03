class AddIndexingToComments2 < ActiveRecord::Migration
  def change
  	add_index :comments, [:user_id, :update_id, :created_at]
  end
end
