class AddInstanceVariablesToComment < ActiveRecord::Migration
  def change
    add_column :comments, :usr_id, :integer
    add_column :comments, :upd_id, :integer
    add_column :comments, :com_id, :integer
    add_column :comments, :content, :string
  end
end
