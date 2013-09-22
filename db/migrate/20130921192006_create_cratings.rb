class CreateCratings < ActiveRecord::Migration
  def change
    create_table :cratings do |t|
      t.integer :rater_id
      t.integer :rated_comment_id

      t.timestamps
    end

    add_index :cratings, [:rater_id,:rated_comment_id], unique: true
  end
end
