class AddParentToComments < ActiveRecord::Migration
  def change
    add_column :comments, :parent, :integer
  	add_index :comments, :parent
  end
end
