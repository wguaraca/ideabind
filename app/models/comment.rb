class Comment < ActiveRecord::Base
	validates :usr_id, presence: true
	validates :content, presence: true
	validates :upd_id, presence: true
end
