class CreateIdeataggings < ActiveRecord::Migration
  def change
    create_table :ideataggings do |t|
      t.integer :idea_id
      t.integer :tag_id

      t.timestamps
    end

    add_index :ideataggings, :idea_id
    add_index :ideataggings, :tag_id
    add_index :ideataggings, [:idea_id, :tag_id], unique: true
  end
end
