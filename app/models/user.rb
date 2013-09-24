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
  has_many :comments

  def rated?(comment)
    self.cratings.find_by(rated_comment_id: comment.id)
  end


  # Change the rating of comment
  # Properly adjust the rating value of the vote_type in "crating" 

  def rate!(comment, vote_type)
    crating = rated?(comment)

    if crating

      if crating.vote_type == "up" && vote_type == "up"
        comment.downvote
        # self.cratings.find_by(rated_comment_id: comment.id).delete
        crating.destroy!
        # crating.delete
      elsif crating.vote_type == "up" && vote_type == "down"
        2.times { comment.downvote }
        crating.vote_type = "down"
        crating.save!
      elsif crating.vote_type == "down" && vote_type == "down"
        comment.upvote
        crating.destroy!
      elsif crating.vote_type == "down" && vote_type == "up"
        2.times { comment.upvote }
        crating.vote_type = "up"
        crating.save!
      end
    else
      crating = cratings.create!(rated_comment_id: comment.id, vote_type: vote_type)
      crating.save

      if vote_type == "up"
        comment.upvote
      else 
        comment.downvote
      end
    end
  end

end
