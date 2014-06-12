class ApiController < ApplicationController

	respond_to :json
	include Devise::Controllers::Helpers
 

	def login
		    @user = User.exists? params[:email]
		    return invalid_login_attempt unless @user
		 
		    if @user.valid_password?(params[:password])
		      sign_in("user", @user)
		      session[:token] = @user.token
		      respond_with @user
		    else
		    	invalid_login_attempt
		    end
	end

	def signout
		@user = User.exists? params[:email]
		unless @user
			render :json=> {:success=>false, :message=>"no such user"}
		else
			sign_out(@user)
			session[:token] =  nil
			respond_with @user
		end
	end

	def create_user
		if User.exists? params[:email]
			render :json=> {:success=>false, :message=>"already_exists"}
		elsif  password_idenical?(params[:password], params[:password_confirmation])
			render :json=> {:success=>false, :message=>"passwords dismissed"}
		else
			@user = User.make_user params

			if @user.valid?
				@user.save
				sign_in @user
				session[:token] = @user.token
				respond_with @user
			else
				render :json=> {:success=>false, :message => @user.errors.messages }
			end
		end
	end

	def create
		@user = User.find_by_token(params:token)
		if @user
			@product = Product.new(product_params)
			@product.user = @user
			@product.save
			respond_with @product
		else
			render :json=> {:success=>false, :message => "first login" }
		end
	end

	def index
		@products =  Product.all_sorted.paginate(page: params[:page])
	end

	def show
		@product = Product.find(params[:id])
		@user = User.find_by_token(@product.owner_token)
    end

    def update
    	@product = Product.find(params[:id])
    	if @product.user == User.find_by_token(params[:token])
    		@product.update_attributes(product_params)
        	respond_with @product
        else
        	render :json=> {:success=>false, :message => "you didn't created this product" }
        end
    end

	def destroy
		@product = Product.find(params[:id])
		if @product.user == User.find_by_token(params[:token])
			@product.destroy
        	render :json=> {:message => "product deleted" }
        else
        	render :json=> {:success=>false, :message => "you didn't created this product" }
        end
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

	def password_idenical?(first, second)
		first != second
	end

end
