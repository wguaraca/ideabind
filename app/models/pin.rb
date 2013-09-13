class Pin < ActiveRecord::Base
  attr_accessible :description
  validates :description, presence: true, length: { minimum: 20, maximum: 100 }
  validates :user_id, presence: true

end
