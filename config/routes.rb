Rails.application.routes.draw do
  devise_for :users
  resources :products do
  	get "delete"
  end

  root to: 'products#index'

end
