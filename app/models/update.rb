class Update < ActiveRecord::Base
	after_save :set_default_rating

	belongs_to :user
	belongs_to :idea
	has_many :comments
	has_many :collaborators, class_name: 'User'

	validates :user_id, presence: true
	validates :title, presence: true
	validates :description, presence: true

	attr_accessible :title, :description

	def set_default_rating
		self.rating = 0
	end

	def sort_default_comments
		self.comments.order("helpfulness DESC, rating DESC")
	end
end
