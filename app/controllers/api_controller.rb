class ApiController < ApplicationController

	respond_to :json
	include Devise::Controllers::Helpers
 

	def login
		    resource = User.find_for_database_authentication(:email=>params[:email])
		    return invalid_login_attempt unless resource
		 
		    if resource.valid_password?(params[:password])
		      sign_in("user", resource)
		      render :json=> {:success=>true, :login=>resource.email}
		    else
		    	invalid_login_attempt
		    end
	end

	def signout
		resource = User.find_for_database_authentication(:email=>params[:email])

		unless resource
			render :json=> {:success=>false, :message=>"no such user"}
		else
			sign_out(resource)
			render :json=> {:success=>true }
		end
	end
	
	

	def create
		respond_with Product.create(product_params)
	end

	def index

		@products =  Product.all_sorted.paginate(page: params[:page])
		respond_with @products
	end

	def show
		@product = Product.find(params[:id])
        respond_with @product
    end

    def update
    	@product = Product.find(params[:id])
    	@product.update_attributes(product_params)
        respond_with @product
    end

	def destroy

        respond_with Product.destroy(params[:id])
    end


	private



	def ensure_params_exist
	    return unless params[:user_login].blank?
	    render :json=>{:success=>false, :message=>"missing user_login parameter"}, :status=>422
	end
 
  	def invalid_login_attempt
    	warden.custom_failure!
    	render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
  	end

	def other_product_params
		{
			title: params[:title], description: params[:description], lat: params[:lat], long:  params[:long]
		}
	end

	def product_params
		params.require(:product).permit(:title, :description, :lat, :long, :avatar)
	end
end
