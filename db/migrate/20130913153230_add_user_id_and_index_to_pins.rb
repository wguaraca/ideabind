class AddUserIdAndIndexToPins < ActiveRecord::Migration
  def change
  	add_column :pins, :user_id, :integer
  	add_index :pins, [:user_id, :created_at]
  end

  
end
