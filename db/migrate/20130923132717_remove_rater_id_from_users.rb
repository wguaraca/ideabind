class RemoveRaterIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :rater_id, :integer
  end
end
