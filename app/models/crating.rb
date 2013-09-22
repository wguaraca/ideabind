class Crating < ActiveRecord::Base
	belongs_to :rater, class_name: 'User'
	belongs_to :rated_comment, class_name: 'Comment'

	attr_accessible :rated_comment_id

	validates :rater_id, presence: true
	validates :rated_comment_id, presence: true
end
