class Product < ActiveRecord::Base
	
	attr_accessible :title, :description, :lat, :long, :avatar, :token
	
	validates :title, presence: true
	validates :description, presence: true
	validates :lat, presence: true
	validates :long, presence: true

	mount_uploader :avatar, AvatarUploader
	belongs_to :user
	has_many :photos, :dependent => :destroy 
	accepts_nested_attributes_for :photos, :allow_destroy => true 

	self.per_page = 5

	def self.all_sorted
		self.all.order(created_at: :desc)
	end

end
