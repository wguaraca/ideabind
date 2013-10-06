class Ideatagging < ActiveRecord::Base

attr_accessible :tag_id

belongs_to :idea, class_name: 'Idea'
belongs_to :tag, class_name: 'Tag'

validates :tag_id, presence: true
validates :idea_id, presence: true
end
	