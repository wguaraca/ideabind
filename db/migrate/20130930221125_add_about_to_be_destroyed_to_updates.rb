class AddAboutToBeDestroyedToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :about_to_be_destroyed, :boolean, default: false
  end
end
