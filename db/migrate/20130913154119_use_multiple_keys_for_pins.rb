class UseMultipleKeysForPins < ActiveRecord::Migration
  def change
  	add_index :pins, [:user_id, :created_at]
  end
end
