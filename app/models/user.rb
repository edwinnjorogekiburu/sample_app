class User < ActiveRecord::Base
  
  attr_accessible :name, :email, :password, :password_confirmation ,:username
  has_many :microposts , dependent: :destroy ,:order => "id DESC"
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name:  "Relationship", dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :recieved_messages , foreign_key: "reciepient_id" , class_name: "Message",:order => "id DESC"
  has_many :sent_messages , foreign_key: "sender_id" , class_name: "Message" ,:order => "id DESC"
  has_secure_password
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :username , presence: true , uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

    private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    public

    def feed
      # This is preliminary. See "Following users" for the full implementation.
      Micropost.from_users_followed_by(self)
    end

    def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
    end

    def follow!(other_user)
      relationships.create!(followed_id: other_user.id)
    end
    
    def unfollow!(other_user)
      relationships.find_by_followed_id(other_user.id).destroy
    end



end