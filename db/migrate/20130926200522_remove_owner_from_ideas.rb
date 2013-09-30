class RemoveOwnerFromIdeas < ActiveRecord::Migration
  def change
    remove_column :ideas, :owner, :string
  end
end
