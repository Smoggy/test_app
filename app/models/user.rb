class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         attr_accessible :email, :password, :token, :username
  before_create :create_token
  has_many :products
  validates :username, presence: true
  
   def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.exists? email
  		self.find_for_database_authentication(:email=>email)
  end

  def self.make_user params
  	self.new(:email => params[:email],
	                 :password => params[:password],
	                 :password_confirmation => params[:password_confirmation])
  end

   private

    def create_token
      self.token =  SecureRandom.urlsafe_base64
    end

end
