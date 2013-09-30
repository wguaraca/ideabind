class RemoveIdeaIdFromIdeas < ActiveRecord::Migration
  def change
    remove_column :ideas, :idea_id, :integer
  end
end
