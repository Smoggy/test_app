

json.product do

	json.id @product.id
  	json.title @product.title
  	json.description @product.description
  	json.avatar @product.avatar.path
  	json.lat	@product.lat
  	json.long	@product.long

end