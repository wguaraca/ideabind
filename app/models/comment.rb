	class Comment < ActiveRecord::Base
		validates :usr_id, presence: true
		validates :content, presence: true
		validates :upd_id, presence: true

		attr_accessible :usr_id, :content, :upd_id
		# has_and_belongs_to_many :users
		has_many :cratings, class_name: 'Crating', foreign_key: "rated_comment_id"
		# has_many :raters, through: :who_rated_comment_rels
		has_many :raters, through: :cratings

		# has_many :who_rated_comment_rels, foreign_key: "user_id"

		def upvote 

		end

		def downvote

		end
	end
