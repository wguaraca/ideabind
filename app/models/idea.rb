class Idea < ActiveRecord::Base
	before_validation :set_defaults

	has_many :ideabinds, foreign_key: :collaborated_idea_id
	has_many :collaborators, through: :ideabinds
	has_many :updates, dependent: :destroy
	has_many :ideataggings
	has_many :tags, through: :ideataggings

	belongs_to :owner, class_name: "User"

	attr_accessible :title, :description, :owner_id
	validates :description, presence: true
	validates :title, presence: true
	validates :owner_id, presence: true



	def set_defaults
		self.rating ||= 0
	end


end
