class CreateIdeabinds < ActiveRecord::Migration
  def change
    create_table :ideabinds do |t|
      t.integer :collaborator_id
      t.integer :collaborated_idea_id

      t.timestamps
    end

    add_index :ideabinds, [:collaborator_id, :collaborated_idea_id], unique: true
  end
end
