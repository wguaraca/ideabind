class AddHelpfulnessToComments < ActiveRecord::Migration
  def change
    add_column :comments, :helpfulness, :boolean, default: false
  end
end
