class AddRatedCommentIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :rated_comment_id, :integer
  end
end
