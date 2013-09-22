class Crating < ActiveRecord::Base
	belongs_to :rater, class_name: 'User'
	belongs_to :rated_comment, class_name: 'Comment'

	attr_accessible :rated_comment_id, :vote_type

	validates :rater_id, presence: true
	validates :rated_comment_id, presence: true
	validates :vote_type, presence: true, 
						inclusion: { in: %w(up down) }
end
