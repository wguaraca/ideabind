class RemoveRaterIdFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :rater_id, :integer
  end
end
