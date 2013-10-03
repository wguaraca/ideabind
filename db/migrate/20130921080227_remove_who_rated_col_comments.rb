class RemoveWhoRatedColComments < ActiveRecord::Migration
  def change
  	remove_column :comments, :who_rated
  end
end
