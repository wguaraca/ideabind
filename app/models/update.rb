class Update < ActiveRecord::Base
	after_save :set_default_rating

	belongs_to :user
	belongs_to :idea
	has_many :comments, dependent: :destroy
	has_many :collaborators, class_name: 'User' # should use join table, has_many through
	has_many :updatetaggings, class_name: 'Updatetagging', foreign_key: 'update_id'
	has_many :tags, through: :updatetaggings
	default_scope -> { order('created_at DESC')}
	# scope :default, -> { where(order:'created_at ASC') }
	# default_scope order:'created_at DESC'

	validates :user_id, presence: true
	validates :title, presence: true
	validates :description, presence: true
	validates :idea, presence: true

	attr_accessible :title, :description, :idea_id	

	def set_default_rating
		self.rating = 0
	end

	def sort_default_comments
		self.comments.order("helpfulness DESC, rating DESC, created_at DESC")
	end

	def destroy 
		self.about_to_be_destroyed = true
		self.save
		# self.comments.destroy_all
		super
	end
end
