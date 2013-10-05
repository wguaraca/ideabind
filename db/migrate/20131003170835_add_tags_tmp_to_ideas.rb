class AddTagsTmpToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :tags_tmp, :string
  end
end
