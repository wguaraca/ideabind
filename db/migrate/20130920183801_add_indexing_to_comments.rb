class AddIndexingToComments < ActiveRecord::Migration
  def change
  	add_index :comments, [:upd_id, :usr_id, :com_id, :created_at]
  end
end
