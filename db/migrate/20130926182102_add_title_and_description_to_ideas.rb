class AddTitleAndDescriptionToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :title, :string
    add_column :ideas, :description, :text
    add_column :ideas, :owner, :integer
  end
end
