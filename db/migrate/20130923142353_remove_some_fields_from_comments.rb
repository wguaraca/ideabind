class RemoveSomeFieldsFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :usr_id, :integer
    remove_column :comments, :com_id, :integer
    remove_column :comments, :rated_comment_id, :integer
    remove_column :comments, :upd_id, :integer
  end
end
