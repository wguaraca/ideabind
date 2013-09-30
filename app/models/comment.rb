	class Comment < ActiveRecord::Base
		after_save :set_par_comment_id_default
		before_save :set_defaults

		# default_scope 

		validates :user_id, presence: true
		validates :content, presence: true, length: { minimum: 140 }, unless: "@parental_deleted"
		validates :update_id, presence: true
		# validates :par_comment_id, presence: true

		# Can usr_id be protected from mass-assignment?


		attr_accessible :content, :update_id
		has_many :cratings, class_name: 'Crating', foreign_key: "rated_comment_id"
		has_many :raters, through: :cratings
		has_many :replies, -> { order "rating DESC" }, class_name: 'Comment', foreign_key: 'parent_id'
		belongs_to :user
		belongs_to :parent, class_name: 'Comment'
		belongs_to :update

		

		def upvote 
			self.rating += 1
		end

		def downvote
			self.rating -= 1
		end

		def set_defaults
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



		def destroy
			# update = Update.where(id: self.update_id)
			# if update.empty? && self.replies.length > 0
			# debugger
			if self.update && !self.replies.empty?
				@parental_deleted = true
				self.content = nil			
				self.save
			else
				self.replies.destroy_all
				super
			end
		end

	end
