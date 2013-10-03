class RenameReputationToRatingsInIdeas < ActiveRecord::Migration
  def change
  	remove_column :ideas, :reputation
  	add_column :ideas, :rating, :integer
  	add_index :ideas, [:rating, :created_at]
  end
end
