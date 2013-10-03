class RemoveParentFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :parent, :integer
  end
end
