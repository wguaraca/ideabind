class Updatetagging < ActiveRecord::Base
	attr_accessible :tag_id

	validates :tag_id, presence: true
	validates :update_id, presence: true

	belongs_to :update, class_name: 'Update'
	belongs_to :tag, class_name: 'Tag'
end
