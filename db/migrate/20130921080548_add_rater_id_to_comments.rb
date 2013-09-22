class AddRaterIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :rater_id, :integer
  end
end
