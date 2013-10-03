class AddRatedCommentIdToWhoRatedCommentRels < ActiveRecord::Migration
  def change
    add_column :who_rated_comment_rels, :rated_comment_id, :integer
  end
end
