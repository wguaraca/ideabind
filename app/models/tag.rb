class Tag < ActiveRecord::Base

	attr_accessible :name
	validates :name, presence: true, uniqueness: { case_sensitive: true }
	# validates :updates, presence: true

	has_many :updatetaggings, class_name: 'Updatetagging', foreign_key: 'tag_id'
	has_many :updates, through: :updatetaggings

	has_many :ideataggings #, class_name: 'Ideatagging', foreign_key: 'tag_id'
	has_many :ideas, through: :ideataggings


	def self.similar_to(name)
		Tag.where('name LIKE ?', '%' + name + '%')
	end

	# Can't find a way to join the two collection proxies together
	# without iterating it through and saving it as an array,
	# hence this way of implementation.

	def self.updates_similar_to(name)
		sim_tags = self.similar_to(name)
		return nil if sim_tags.nil? 

		arr = Array.new() 
	
		sim_tags.each do |tag| 
			tag.updates.each do |update|
				arr << update
			end
		end

		return arr
	end

	def self.ideas_similar_to(name)
		sim_tags = self.similar_to(name)
		return nil if sim_tags.nil? 

		arr = Array.new() 
	
		sim_tags.each do |tag| 
			tag.ideas.each do |idea|
				arr << idea
			end
		end

		return arr
	end

	def safe_to_destroy?
		self.updates.empty? && self.ideas.empty?
	end
end
