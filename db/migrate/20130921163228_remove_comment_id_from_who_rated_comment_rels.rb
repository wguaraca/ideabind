class RemoveCommentIdFromWhoRatedCommentRels < ActiveRecord::Migration
  def change
    remove_column :who_rated_comment_rels, :comment_id, :integer
  end
end
