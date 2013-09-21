class AddWhoRatedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :who_rated, :integer
  end
end
