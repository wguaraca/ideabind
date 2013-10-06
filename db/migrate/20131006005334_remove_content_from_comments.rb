class RemoveContentFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :content, :string
    add_column :comments, :content, :text
  end
end
