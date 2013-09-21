	class Comment < ActiveRecord::Base
		validates :usr_id, presence: true
		validates :content, presence: true
		validates :upd_id, presence: true

		attr_accessible :usr_id, :content, :upd_id
		# has_many :users, through: :who_rated_comment_rels, source: :
		# has_many :who_rated_comment_rels, foreign_key: "user_id"

		def upvote 

		end

		def downvote

		end
	end
