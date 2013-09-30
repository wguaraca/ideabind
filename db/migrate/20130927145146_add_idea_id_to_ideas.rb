class AddIdeaIdToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :idea_id, :integer
    add_index :ideas, :idea_id, unique: true
  end
end
