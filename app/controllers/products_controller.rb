class ProductsController < ApplicationController
	respond_to :html, :js
	before_action :authenticate_user!, :except => [:index, :show]

	
	def index

		@products =Product.all_sorted.paginate(page: params[:page])
	end

	def show
		@product = Product.find(params[:id])
	end

	def new
		@product = Product.new
	end

	def create

		@products = Product.all_sorted.paginate(page: params[:page])
		@product = Product.new(product_params)
		@product.user = current_user

		@product.save
		
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
		if @product.user.eql? current_user
			@product.update_attributes(product_params)
			
		else
			@product.errors.add(:error, "you are not owner")
		end
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

		if @product.user.eql? current_user
			@product.destroy
		else
			@product.errors.add(:error, "you are not owner")
		end
	end

	private 

	def product_params
		params.require(:product).permit(:title, :description, :lat, :long, :avatar)
	end

	def add_token
		authenticate_user!
		session[:token] = current_user.token
	end

	def delete_token
		session[:token] = nil
	end

end
