class AddOwnerBooleanToIdeabind < ActiveRecord::Migration
  def change
    add_column :ideabinds, :owner, :boolean, default: :false
  end
end
