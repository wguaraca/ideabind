class AddSkillsAndReputationToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :reputation, :integer
  	add_column :users, :skill_1, :string
  	add_column :users, :skill_2, :string
  	add_column :users, :skill_3, :string

  	add_index :users, :skill_1
  	add_index :users, :skill_2
  	add_index :users, :skill_3
  end
end
