class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :validatable, :token_authenticatable, :authentication_keys => [:login]
    #:recoverable, :rememberable, :trackable, , :confirmable

  #Define attribute accessor
  attr_accessible :email, :password, :password_confirmation, :current_password, :remember_me, 
    :first_name, :last_name, :username, :terms_of_service, :email_confirmation, :login, :address, 
    :city, :state, :zipcode, :country, :phone, :image, :image_cache
  attr_accessor :current_password, :login
  mount_uploader :image, ImageUploader 
  
  #Define validation for every attribute
  validates :first_name, :presence => true, :format => { :with => /^[a-zA-Z ]+$/, :message => "Only letters allowed"  }
  validates :last_name, :presence => true, :format => { :with => /^[a-zA-Z ]+$/, :message => "Only letters allowed"  }
  validates :email, :presence => true, :format => { :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/ }
  validates :terms_of_service, :on => :create, :acceptance => true
  validates :username, :allow_blank => true, :uniqueness => true, :format => { :with => /^[\w]{4,}$/, :message => "should at-least contain 4 valid characters" }

  has_many :authentications, :dependent => :delete_all
  has_many :book_details, :dependent => :destroy
  has_many :notifies, :dependent => :destroy
  
  #by default devise provides login with email
  #If also need to login with username then need to overrides this method
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
  
  #Fetch the full name of the user
  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def profile_icon
    if self.image.present?
      self.image_url(:small_thumb).present? ? self.image_url(:small_thumb) : "/assets/avatar.jpg"
    elsif self.socail_img.present?
      self.socail_img.present? ? self.socail_img : "/assets/avatar.jpg"
    else
      "/assets/avatar.jpg"
    end
  end

  def apply_omniauth(auth)
    # In previous omniauth, 'user_info' was used in place of 'raw_info'
    if auth['provider'] == 'facebook'
      self.email = auth['extra']['raw_info']['email']
      self.first_name = auth['extra']['raw_info']['first_name']
      self.last_name = auth['extra']['raw_info']['last_name']
      self.address = auth['extra']['raw_info']['location']['name'] if auth['extra']['raw_info']['location'].present?
      self.image = auth['extra']['raw_info']['image']
      self.socail_img = "https://graph.facebook.com/#{auth[:uid]}/picture?type=small"
    else
      self.email = auth['info']['email']
      self.first_name = auth['info']['first_name']
      self.last_name = auth['info']['last_name']
      self.address = auth['info']['location'] if auth['info']['location'].present?
      self.image = auth['info']['image']
    end
    # saving fb info into db
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  end
  
end
