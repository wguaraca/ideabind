class CreateUpdatetaggings < ActiveRecord::Migration
  def change
    create_table :updatetaggings do |t|
      t.integer :tag_id
      t.integer :update_id

      t.timestamps
    end

    add_index :updatetaggings, [:tag_id, :update_id], unique: true
  end
end
