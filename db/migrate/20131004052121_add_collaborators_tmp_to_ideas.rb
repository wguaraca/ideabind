class AddCollaboratorsTmpToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :collaborators_tmp, :string
  end
end
