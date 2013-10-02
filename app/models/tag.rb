class Tag < ActiveRecord::Base

	attr_accessible :name
	validates :name, presence: true, uniqueness: { case_sensitive: true }

	has_many :updatetaggings, class_name: 'Updatetagging', foreign_key: 'tag_id'
	has_many :updates, through: :updatetaggings

	# Linear search of tag names to simulate listing of updates
	# via partially-filled tag names
	
	# scope :similar_to, -> { |n| where("name LIKE n")}
	# scope :similar_to, lambda{ |n| where("name LIKE n")}
	# def similar_to
	# 	tags = Tag.all 


	# end

	def self.similar_to(name)
		Tag.where('name LIKE ?', '%' + name + '%')
	end

	# Can't find a way to join the two collection proxies together
	# without iterating it through and saving it as an array...

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
end
