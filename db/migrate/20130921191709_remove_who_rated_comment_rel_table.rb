class RemoveWhoRatedCommentRelTable < ActiveRecord::Migration
  def change
  	drop_table :who_rated_comment_rels
  end
end
