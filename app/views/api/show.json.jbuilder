json.product do

	json.id @product.id
  	json.title @product.title
  	json.description @product.description
    json.avatar @product.avatar.path
  	json.lat	@product.lat
  	json.long	@product.long
  	json.author do
       json.email @product.user.email
       json.name @product.user.username
       json.token @product.user.token
  	end

end