class Idea < ActiveRecord::Base
	before_validation :set_defaults

	has_many :ideabinds, foreign_key: :collaborated_idea_id
	has_many :collaborators, through: :ideabinds
	has_many :updates, dependent: :destroy
	has_many :ideataggings
	has_many :tags, through: :ideataggings

	belongs_to :owner, class_name: "User"

	attr_accessible :title, :description, :owner_id, :location, :tags_tmp, :collaborators_tmp
	validates :description, presence: true
	validates :title, presence: true
	validates :owner_id, presence: true
	validates :location, presence: true



	def set_defaults
		self.rating ||= 0
	end

	def build_ideatags
		tags_arr = self.tags_tmp.split("\s")
		tags_arr.each do |tag|
			tag_model = Tag.find_by_name(tag)
			tag_model ||= Tag.create(name: tag)
			
			ideatagging = self.ideataggings.create(tag_id: tag_model.id)
			ideatagging.save

		end
	end
end
