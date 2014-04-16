Rails.application.routes.draw do
  resources :products do
  	get "delete"
  end

  root to: 'products#index'

  get "products/new_release" => 'products#new_release', :as => :new_release
end
