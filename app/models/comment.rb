	class Comment < ActiveRecord::Base
		before_save :set_rating_def
		after_save :set_rated_comment_id_def

		validates :usr_id, presence: true
		validates :content, presence: true
		validates :upd_id, presence: true
		
		# Can usr_id be protected from mass-assignment?


		attr_accessible :usr_id, :content, :upd_id
		has_many :cratings, class_name: 'Crating', foreign_key: "rated_comment_id"
		has_many :raters, through: :cratings

		def upvote 
			self.rating += 1
		end

		def downvote
			self.rating -= 1
		end

		def set_rating_def
			self.rating ||= 0
		end

		def set_rated_comment_id_def
			self.rated_comment_id = id
		end
	end
