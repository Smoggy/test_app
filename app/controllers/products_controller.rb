class ProductsController < ApplicationController

	def index

	end

	def show
		@product = Product.find(params[:id])
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(product_params)
    	if @product.save
      
      	redirect_to @product
    	else
      		render 'new'
    	end
	end

	def update

	end

	def destroy

	end

	private 

	def product_params
		params.require(:product).permit(:title, :description, :lat, :long )
	end
end
