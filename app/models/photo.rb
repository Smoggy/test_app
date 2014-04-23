class Photo < ActiveRecord::Base
	belongs_to :product

	attr_accessible :photo
	mount_uploader :photo, PhotoUploader

end
