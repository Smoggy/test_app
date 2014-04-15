class Product < ActiveRecord::Base
	validates :title, presence: true
	validates :description, presence: true
	validates :lat, presence: true
	validates :long, presence: true
end
