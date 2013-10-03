class WhoRatedCommentRel < ActiveRecord::Base
	belongs_to :rater,   class_name: "User", foreign_key: :rater_id #, primary_key: :rater_id
	belongs_to :rated_comment, class_name: "Comment", foreign_key: :comment_id #, primary_key: :comment_id

	validates :rater_id, presence: true
	validates :rated_comment_id, presence: true
end
