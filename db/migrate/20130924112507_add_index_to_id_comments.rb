class AddIndexToIdComments < ActiveRecord::Migration
  def change
  	add_index :comments, :id, unique: true end
end
