class WhoRatedCommentRel < ActiveRecord::Base
	belongs_to :user,    class_name: "User"
	belongs_to :comment, class_name: "Comment" 

end
