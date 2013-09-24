class IndexParentIdOfComments < ActiveRecord::Migration
  def change
  	add_index :comments, :parent_id
  end
end
