class AddIndexToHelpfulnessComments < ActiveRecord::Migration
  def change
  	add_index :comments, :helpfulness
  end
end
