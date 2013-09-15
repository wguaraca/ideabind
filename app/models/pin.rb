class Pin < ActiveRecord::Base
  attr_accessible :description, :user_id
  validates :description, presence: true, length: { minimum: 20, maximum: 100 }
  validates :user_id, presence: true
  belongs_to :user
  default_scope -> { order('created_at DESC') } 
end

