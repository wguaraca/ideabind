class AddMultipleUniqueIndexingToWhoRatedCommentRels < ActiveRecord::Migration
  def change
  	add_index :who_rated_comment_rels, [:rated_comment_id, :rater_id], unique: true
  end
end
