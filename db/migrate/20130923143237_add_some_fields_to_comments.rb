class AddSomeFieldsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :integer
    add_column :comments, :par_comment_id, :integer
    add_column :comments, :update_id, :integer
  end
end
