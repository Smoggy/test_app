class Product < ActiveRecord::Base
	
	attr_accessible :title, :description, :lat, :long, :avatar

	validates :title, presence: true
	validates :description, presence: true
	validates :lat, presence: true
	validates :long, presence: true

	mount_uploader :avatar, AvatarUploader

	self.per_page = 5

	def self.all_sorted
		self.all.order(created_at: :desc)
	end

end
