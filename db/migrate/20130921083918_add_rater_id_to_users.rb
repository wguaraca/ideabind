class AddRaterIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rater_id, :integer
  end
end
