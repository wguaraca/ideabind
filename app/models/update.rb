class Update < ActiveRecord::Base
	after_save :set_default_rating

	belongs_to :user
	belongs_to :idea
	has_many :comments, dependent: :destroy
	has_many :collaborators, class_name: 'User' # should use join table, has_many through

	validates :user_id, presence: true
	validates :title, presence: true
	validates :description, presence: true
	validates :idea, presence: true

	attr_accessible :title, :description, :idea_id	

	def set_default_rating
		self.rating = 0
	end

	def sort_default_comments
		self.comments.order("helpfulness DESC, rating DESC")
	end
end
