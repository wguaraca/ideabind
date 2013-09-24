	class Comment < ActiveRecord::Base
		after_save :set_par_comment_id_default
		before_save :set_rating_default

		validates :user_id, presence: true
		validates :content, presence: true
		validates :update_id, presence: true
		# validates :par_comment_id, presence: true

		# Can usr_id be protected from mass-assignment?


		attr_accessible :content, :update_id
		has_many :cratings, class_name: 'Crating', foreign_key: "rated_comment_id"
		has_many :raters, through: :cratings
		belongs_to :user
		belongs_to :parent, class_name: 'Comment', foreign_key: 'par_comment_id'
		has_many   :replies, class_name: 'Comment', foreign_key: 'par_comment_id'

		def upvote 
			self.rating += 1
		end

		def downvote
			self.rating -= 1
		end

		def set_rating_default
			self.rating ||= 0
		end

		def set_par_comment_id_default
			self.par_comment_id = self.id
		end

		# Toggle comment as helpful by collaborators.
		
		def helpful!

		end

		def helpful?

		end

	end
