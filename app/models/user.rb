class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



  # Setup accessible (or protected) attributes for your model

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  validates :name, presence: true, 
                   uniqueness: { case_sensitive: false },
                   length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
										uniqueness: { case_sensitive: false }
  # validates_uniqueness_of :name

	has_many :pins, dependent: :destroy
  # has_many :who_rated_comment_rels, foreign_key: "comment_id", dependent: :destroy
  has_many :who_rated_comment_rels, foreign_key: "user_id", dependent: :destroy
  # has_many :comments, through: :who_rated_comment_rels, source: :comment 
	# validates :password, presence: true, length: { maximum: }

end
