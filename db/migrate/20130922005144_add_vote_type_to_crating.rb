class AddVoteTypeToCrating < ActiveRecord::Migration
  def change
    add_column :cratings, :vote_type, :string
  end
end
