json.product do

	json.id @product.id
  	json.title @product.title
  	json.description @product.description
  	json.lat	@product.lat
  	json.long	@product.long
  	json.author do
       json.email @user.email
       json.name @user.username
       json.token @user.token
  	end

end