class Ideabind < ActiveRecord::Base

	belongs_to :collaborator, class_name: 'User'
	belongs_to :collaborated_idea, class_name: 'Idea'

	attr_accessible :collaborated_idea_id

	validates :collaborator_id, presence: true
	validates :collaborated_idea, presence: true
end
