class User < ActiveRecord::Base
  # can we remove unused associations
  attr_accessor :password
  attr_accessible :first_name, :last_name, :address, :city, :country, :phone, :email, :password, :password_confirmation

  CITIES = [ "Beirut" ]
  COUNTRIES = [ "Lebanon" ]

  has_many :orders, :dependent => :destroy

  validates :first_name, :presence => true,
                   :length => {:maximum => 50}
  validates :last_name, :presence => true,
                   :length => {:maximum => 50}

  validates :address, :presence => true,
                   :length => {:maximum => 150}

  validates :phone, :presence => true,
                   :length => {:maximum => 150}

  validates :city,    :inclusion => CITIES
  validates :country, :inclusion => COUNTRIES

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :presence => true,
                    :format => email_regex,
                    #:uniqueness => true
                    :uniqueness => {:case_sensitive => false}


  # Automatically create the virtual attribute 'password_confirmation'.
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }

  has_many :microposts, :dependent => :destroy
  has_many :relationships, :foreign_key => "follower_id",
                           :dependent => :destroy
  has_many :following, :through => :relationships,
                       :source => :followed
  has_many :reverse_relationships, :foreign_key => "followed_id",
                       :class_name => "Relationship",
                       :dependent => :destroy
  has_many :followers, :through => :reverse_relationships,
                       :source => :follower


  before_save :encrypt_password

  def name= (combined_name)
    unless combined_name.blank?
      first_name, last_name = combined_name.split(' ',2)
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    # Compare encrypted_password with the encrypted version of
    # submitted_password.
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def feed
    # This is preliminary. See Chapter 12 for the full implementation.
    #Micropost.where("user_id = ?", id)
    Micropost.from_users_followed_by(self)
  end

  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end

  private

    #def encrypt_password
      # if we ommitted self.Ruby would create a local variable called
      # encrypted_password, which isn't what we want at all.
      #self.encrypted_password = encrypt(self.password)
    #  self.encrypted_password = encrypt(password) # we could have used self.password
      # (Of course, as we've noted, the self is not optional when
      # assigning to an attribute, so we have to write self.encrypted_password
      # in this case.)
    #end

    #def encrypt(string)
    #  string # Only a temporary implementation!
    #end

    def encrypt_password
      # new_record? boolean method, which returns true if the object has not
      # yet been saved to the database
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end


# == Schema Information
# Schema version: 20110513044037
#
# Table name: users
#
#  id                 :integer(4)      not null, primary key
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean(1)
#  first_name         :string(255)
#  last_name          :string(255)
#  address            :string(255)
#  city               :string(255)
#  country            :string(255)
#  phone              :string(255)
#

