class IndexParCommentIdAndOthersInComments < ActiveRecord::Migration
  def change
  	add_column :comments, :depth, :integer
  	add_column :comments, :idea_id, :integer
  	add_index  :comments, [:idea_id, :update_id], unique: true
  end
end
