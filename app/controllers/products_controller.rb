class ProductsController < ApplicationController

	def index
		@products = Product.all.paginate(page: params[:page])
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
      		redirect_to products_path
    	else
      		render 'new'
    	end
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		if Product.find(params[:id]).update_attributes(product_params)
      		redirect_to products_path
    	else
      		render 'edit'
    	end
	end

	def destroy
		product = Product.find(params[:id])
		product.destroy
		redirect_to products_path
	end

	private 

	def product_params
		params.require(:product).permit(:title, :description, :lat, :long )
	end
end
