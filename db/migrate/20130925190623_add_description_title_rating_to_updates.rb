class AddDescriptionTitleRatingToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :title, :string
    add_column :updates, :description, :text
    add_column :updates, :rating, :integer

    add_index :updates, :created_at
  end
end
