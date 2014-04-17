class ProductsController < ApplicationController
	respond_to :html, :js
	before_action :authenticate_user!, :except => [:index, :show]


	def index
		@products = Product.all_sorted.paginate(page: params[:page]) 
	end

	def show
		@product = Product.find(params[:id])
	end

	def new
		@product = Product.new
	end

	def create
		@products = Product.all_sorted.paginate(page: params[:page])
		@product = Product.create(product_params)


		respond_to do |format|
      		format.html { render :index } 
      		format.js
    	end
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		@products = Product.all_sorted.paginate(page: params[:page])
		@product = Product.find(params[:id])

		@product.update_attributes(product_params)

		respond_to do |format|
      		format.html { render :index } 
      		format.js
    	end
	end

	def delete
		@product = Product.find(params[:product_id])
	end


	def destroy
		@products = Product.all_sorted.paginate(page: params[:page])
		@product = Product.find(params[:id])
		@product.destroy
	end

	private 

	def product_params
		params.require(:product).permit(:title, :description, :lat, :long, :avatar)
	end
end
