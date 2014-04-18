
json.pagination do
	json.total_page @products.total_pages
	json.current_page  @products.current_page
	json.per_page @products.per_page
end

json.products @products do |product|
  json.id product.id
  json.title product.title
  json.description product.description
  json.avatar product.avatar
  json.lat	product.lat
  json.long	product.long
end