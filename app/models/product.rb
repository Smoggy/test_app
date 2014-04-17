class Product < ActiveRecord::Base
	validates :title, presence: true
	validates :description, presence: true
	validates :lat, presence: true
	validates :long, presence: true

	mount_uploader :avatar, AvatarUploader

	def self.all_sorted
		self.all.order(created_at: :desc)
	end

end
