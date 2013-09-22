class User < ActiveRecord::Base
	before_save do 
    self.email = email.downcase 
    # self.rater_id = self.id
  end
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



  # Setup accessible (or protected) attributes for your model

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  validates :name, presence: true, 
                   uniqueness: { case_sensitive: false },
                   length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }


	has_many :pins, dependent: :destroy

  has_many :cratings, foreign_key: 'rater_id', class_name: 'Crating'#, dependent: :destroy
  has_many :rated_comments, through: :cratings

  def rated?(comment)
    cratings.find_by(rated_comment_id: comment.id)
  end

  def rate!(comment, num)
    cratings.create!(rated_comment_id: comment.id)
    if num == 1
      comment.upvote
    else 
      comment.downvote
    end

  end

  

end
